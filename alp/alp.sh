#!/usr/bin/env bash

set -aeou pipefail

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function printHelp(){
    cat << EOF
Usage ${0##*/} [options..]
-h,-?, --help           Show help and exit
-n, --vm-name           Name of kvm domain
-N, --network           Name of kvm network
-v, --vcpu              Number of vCPUs
-m, --memory            Memory in MM
-V, --vm-path           Path to store VM disks
-i, --img-path          Path to alp images
-I, --iso-path          Path to ignition/combultion ISO
-c, --create-vm         create a VM
-s, --start-vm          start the instance
-S, --stop-vm           Stop the instance
-C, --connect-vnc       Connect to VNC"
-q, --qemu              qumu connection URI
-d, --disk-path         Path to ignition/combultion root directory
-l, --disk-label        Label of ignition/combultion ISO volume
-b, --bash-completion   Bash completion for ${0##*/}
--clean-up              Remove VM, ISO and disks
EOF
}

function bash_completion(){
    cat << EOF
ALP_COMPLETE_SINGLE_PARAM="\
  --help
  --create-vm
  --start-vm
  --stop-vm
  --connect-vnc
  --bash-completion
  --clean-up"

ALP_COMPLETE_TWO_PARAM="\
  --vm-name
  --network
  --vcpu
  --memory
  --vm-path
  --img-path
  --iso-path
  --qemu
  --disk-path
  --disk-label"


_alp_complete()
{
    cur="\${COMP_WORDS[COMP_CWORD]}"
    prev="\${COMP_WORDS[COMP_CWORD-1]}"
    if [[ "\$ALP_COMPLETE_TWO_PARAM" == *"\$prev"* ]]; then
        suggestions=""
    else
        suggestions="\$ALP_COMPLETE_SINGLE_PARAM \$ALP_COMPLETE_TWO_PARAM"
    fi
    if [[ "\${suggestions}x" == "x" ]];then
        COMPREPLY=()
    else
        COMPREPLY=( \$(compgen -W "\${suggestions}" -- \${cur}) )
    fi


}

complete -F _alp_complete ./${0##*/}
EOF
}

function create_vm(){
    if [[ $(virsh list --name --all | grep ${VM_NAME} -c) -ne 0 ]]; then
        echo "${VM_NAME} already exists"
        exit 1
    fi
    echo "* Creating ignition/combultion ISO"
    butane --pretty --strict --output ${DISK_PATH}/ignition/config.ign ${DISK_PATH}/ignition/${VM_NAME}.fcc
    mkisofs -full-iso9660-filenames -o ${ISO_PATH}/${VM_NAME}.iso -V ${DISK_LABEL} ${DISK_PATH}
    echo "* Copy ALP image"
    cp ${IMG_PATH} ${VM_PATH}/${VM_NAME}.qcow2
    echo "* Creating VM"
    virt-install --name ${VM_NAME} \
        --vcpus ${VCPU} \
        --memory ${MEMORY} \
        --os-variant opensusetumbleweed \
        --network network=${NETWORK_NAME} \
        --graphics=vnc \
        --disk path=${VM_PATH}/${VM_NAME}.qcow2 \
        --disk path=${ISO_PATH}/${VM_NAME}.iso \
        --noautoconsole \
        --import
    # Waith until running
    while [[ $(virsh list --name --state-running | grep ${VM_NAME} -c) -eq 0 ]]; do sleep 1; done
}

function clean_up(){
    if [[ $(virsh list --name --state-running | grep ${VM_NAME} -c) -eq 1 ]]; then
        stop_vm
    fi
    virsh undefine $VM_NAME
    rm ${VM_PATH}/${VM_NAME}.qcow2
    rm ${ISO_PATH}/${VM_NAME}.iso
    echo "Clean up complete"
    exit 0
}

function start_vm(){
    if [[ $(virsh list --name --state-running | grep ${VM_NAME} -c) -eq 1 ]]; then
        echo "$VM_NAME already started"
        return
    fi
    virsh start --domain $VM_NAME
}

function stop_vm(){
    if [[ $(virsh list --name --state-running | grep ${VM_NAME} -c) -eq 0 ]]; then
        return
    fi
    virsh destroy --domain $VM_NAME
}


#
# Main Script
#

VCPU="${VCPU:-2}"
MEMORY="${MEMORY:-4096}"
VM_PATH="${VM_PATH:-${SCRIPTDIR}/VMs}"
ISO_PATH="${ISO_PATH:-${SCRIPTDIR}/iso}"
IMG_PATH="${IMG_PATH:-${SCRIPTDIR}/img/ALP-Micro.x86_64-0.1-Default-qcow-Build3.5.qcow2}"
VM_NAME="${VM_NAME:-alp}"
NETWORK_NAME="${NETWORK_NAME:-default}"
CREATE_VM="${CREATE_VM:-false}"
START_VM="${START_VM:-false}"
STOP_VM="${STOP_VM:-false}"
CONNECT_VNC="${CONNECT_VNC:-false}"
QEMU="${QEMU:-qemu:///system}"
DISK_PATH="${DISK_PATH:-${SCRIPTDIR}/disk}"
DISK_LABEL="${DISK_LABEL:-ignition}"
CLEAN_UP="${CLEAN_UP:-false}"

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|-\?|--help)
            printHelp
            exit
            ;;
        -v|--vcpu)
            VCPU="$2"
            shift
            shift
            ;;
        -n|--vm-name)
            VM_NAME="$2"
            shift
            shift
            ;;
        -N|--network-name)
            NETWORK_NAME="$2"
            shift
            shift
            ;;
        -m|--memory)
            MEMORY="$2"
            shift
            shift
            ;;
        -V|--vm-path)
            VM_PATH="$2"
            shift
            shift
            ;;
        -I|--iso-path)
            ISO_PATH="$2"
            shift
            shift
            ;;
        -c|--create-vm)
            CREATE_VM="true"
            shift
            ;;
        -C|--connect-vnc)
            CONNECT_VNC="true"
            shift
            ;;
        -s|--start-vm)
            START_VM="true"
            shift
            ;;
        -S|--stop-vm)
            STOP_VM="true"
            shift
            ;;
        -q|--qemu)
            QEMU="$2"
            shift
            shift
            ;;
        --clean-up)
            CLEAN_UP="true"
            shift
            ;;
        --disk-label)
            DISK_LABEL="$2"
            shift
            shift
            ;;
        -b|--bash-completion)
            bash_completion
            exit
            ;;
        -?*)
            printf "'%s' is not a valid option\n" "$1" >&2
            exit 1
            ;;
        *)                 #Break out of case, no more options
            break
    esac
done

[[ "$CLEAN_UP" == "true" ]] && clean_up
[[ "$CREATE_VM" == "true" ]] && create_vm
[[ "$START_VM" == "true" ]] && start_vm
[[ "$STOP_VM" == "true" ]] && stop_vm
[[ "$CONNECT_VNC" == "true" ]] && virt-viewer --connect "$QEMU" --wait ${VM_NAME} &



if [[ $(virsh list --name --state-running | grep ${VM_NAME} -c) -eq 0 ]]; then
    echo "${VM_NAME} is not running"
    exit
fi

echo "connect with : virt-viewer --connect $QEMU --wait ${VM_NAME} &"
echo "IP           : $(virsh domifaddr ${VM_NAME} | sed -n 's/.* \(.*\)\/.*/\1/p')"
