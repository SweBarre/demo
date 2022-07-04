# Data Loss Prevention - VISA Credit card number

This demo shows how NeuVector can block data though it's deep packet inspection facility.


## Prep

We will be using the Demo Guestbook application in this demo.
```
install_guestbook = true
```

The run
```
terraform apply
```

## Demo

1. Login to the guestbook demo application and add some posts, also refresh the browser a couple of times so traffic is generated between frontend<->redis-master and frontend<->redis-replica. Link to guestbook application is showed in the `terraform output` command.
2. Login to NeuVector and select 'Network Activity', filter on Default namespace and hide any other pods that is not relevant for this demo. It should look something like this.
![Network Activity](https://user-images.githubusercontent.com/254416/176678315-5c76c47c-c40f-4a87-9d4c-869e850a90d8.png)
3. Add one or more posts to the guestbook with some 'fake' credit card numbers
```
4916-1605-4436-9207
4024-0071-7720-4947
4532-0613-8599-3721
4024-0071-9285-6440
4929-1542-9899-6849
4539-5014-8178-8106
4485-2800-2097-2372
4477-7816-1271-4114
4024-0071-3251-3762
4556-5151-4015-0175
```
4. Enable the `sensor.creditcard` DLP Sensor on the `nv.guestbook-redis-replica.default` security group by clicking on Policy->Groups, selct `nv.guestbook-redis-replica.default` and click DLP 
![Screenshot from 2022-07-04 10-04-53](https://user-images.githubusercontent.com/254416/177110859-0964fe27-f75a-4210-8482-f100f803160b.png)
5. Refresh the guestbook app browser and head back to the NeuVector UI and look in Notifications->Security Events, it should now alert on VISA credit card sensor.
6. set the `nv.guestbook-redis-replica.default` security group in protect mode
7. and refresh the guestbook app browser, the data should now be blocked.
8. head back to the NeuVector UI and look in Notifications->Security Events and noticed that the data has been blocked, also showcase the packat capture feature in the alert for forensic purposes.
