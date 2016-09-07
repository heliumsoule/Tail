Trackr
======

Eye tracking application for the iOS client with hosting on Amazon EC2 instance.

To access the Amazon CLI, type
sudo ssh -i key.pem Type_Your_AWSServer_Location_Here

Once in the CLI, type 

`sudo service mongo start`
to start mongodb if mongodb is not already started.

To access the data, 
type

`mongo`

`use mongo`

`db.users.find({}).pretty()`

To export data from mongodb type

`mongoexport --db mongo --collection users --out output.csv`

To start the EC2 instance (should already be started), type
`sudo pm2 start app.js`
while in the /home/ec2-user/node_server directory

The server's baseURL is **Type_Your_AWSServer_Location_Here**

To copy a file from AmazonEC2 to the current directory
scp -i key.pem ec2-user@54.87.129.225:/home/ec2-user/filename .

##REQUESTS
###Creating User Location (POST)
```
/user/update_user_location
{
	"id": "571aee7d552ae09c5fe45f59", "latitude": "42.3601", "longitude": "71.0942", 
	"time": "22:42 April 22nd 2016", "altitude": "2", "speed": "0", "floor": "4", 
	"horizontal_acc": "2", "vertical_acc": "3"
}
```
A successful server response should look like
```
{"message":"Location data successfully added"}
```
###Creating A User (POST)
```
/user/create_user
{"fname": "Tiffany", "lname": "Wong"}
```
A successful server response should look like
```
{
	message: "User " + user_fname + " " + user_lname + " created.",
	data: user_to_add._id
}
```






