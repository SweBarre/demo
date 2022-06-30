# How to Mitigate the SACK Panic DDoS Attack

This demo is created from the blog post at [NeuVector](https://blog.neuvector.com/article/mitigate-sack-panic-ddos-attack).
Read through that text to understand the context and how to proceed with the Demo.

This text is a proposal and some tips to make the demo flow in the demo environment.

## Prep
make sure you have the following two variables set in your `terraform.tfvars`.
```
install_guestbook = true
install_kali      = true
```

The run
```
terraform apply
```

Make sure that you are using a `kubeconf` file that have access to default namespace in the demo cluster, you could use the `kubeconf` created when you ran the `terraform apply` command 
```
export KUBECONFIG=$(pwd)/kubeconf
```

## Demo

1. Login to the guestbook demo application and add some posts, also refresh the browser a couple of times so traffic is generated between frontend<->redis-master and frontend<->redis-replica. Link to guestbook application is showed in the `terraform output` command.
2. Login to NeuVector and select 'Network Activity', filter on Default namespace and hide any other pods that is not relevant for this demo. It should look something like this.
![Network Activity](https://user-images.githubusercontent.com/254416/176678315-5c76c47c-c40f-4a87-9d4c-869e850a90d8.png)

3. Login to the kali-linux container
```
kubectl exec -it $(kubectl get pods --selector=app=kali-kali --template "{{range .items}}{{.metadata.name}}{{\"\n\"}}{{end}}") -- bash
```
4. Inside the kali linux container we simulate the attack by sending TCP SYN packets with very small MSS value, targeting the `guestbook-redis-master` database, let the command run during the demo
```
hping3 -S -p 6379 --tcp-mss 128 guestbook-redis-master
```
5. check the 'Network Activity' screen and a red line has appeared between kali-kali and the guestbook-redis-master. (you might need to refresh the view by clicking the refresh button)
![2-network_activity_ddos](https://user-images.githubusercontent.com/254416/176680459-c0e62bd6-6b06-4164-9f57-a0bafac07637.png)
6. click the red line to open up some additional information on the network traffic
![3_clicking_line_ddos](https://user-images.githubusercontent.com/254416/176681017-db708044-ad8e-4d8b-b667-4271d518217c.png)
7. change the mode on the `guestbook-redis-master` do protect mode by right clicking and select 'Protect'
8. Notice how the `hping3` command stop getting replies (protect mode blocks that traffic now)
9. In NeuVector GUI go to 'Notifications/Security Events', before the target was set to protect mode NeuVector just alerted. After Protect mode the traffic was denied.
10. Click on one of the Deny-events to get more information, also showcase the packet capture feature in pcap format

## Clean up.
1. Ctrl-c to stop the `hping3` command in the kali-linux container.
2. type `exit` to exit the kali-linux container.
