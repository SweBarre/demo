# Remote shell - struts exploit

This demo creates a remote shell using the Apache Struts CVE-2017-9805 Exploit

## Prep
make sure you have the following two variables set in  your `terraform.tfvars`.
```
install_orders     = true
```

The run
```
terraform apply
```

Make sure that you are using a `kubeconf` file that have access to default namespace in the demo cluster, you could use the `kubeconf` created when you ran the `terraform apply` command·
```
export KUBECONFIG=$(pwd)/kubeconf
```

## Demo
1. login to the super-app application, the link to the web app is provided in the `terrarom output`, and generate some traffic by refreshing the page, create a order, delete an order.

2. validate the policy group `nv.struts-orders.default` processes and network rules

3. put the policy group `nv.struts-orders.default` in `protect mode`

4. connect to the client with ssh (see connection string in terraform output) and start a nc process to act as reverse shell
```
nc -lvp 1337

```

5. in a second terminal, ssh to the client (see connection string in terraform output) and execute the attack payload. The exact command is written to `~/struts1.sh` and can be executed with
```
sh struts1.sh
```

6. Look in the Neuvector security events how the Struts RCE is blocked

7. Put the policy group `nv.struts-orders.default` in `monitor mode` and execute the rce payload again
```
sh struts1.sh
```
notice how the orders workload connects to the reversed shell and execute some commands there, like `whoami` `ls -l`, etc...

8. Look in the Neuvector security events how Neuvector now warns about different violations on the security policy, each warning is one layer of protection so even if this was a zero day the other warnings would block the attempt in protect mode.
