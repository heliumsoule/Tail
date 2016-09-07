var User = require('../models/User.js');
var Location = require('../models/Location.js');

exports.create_user = function(req, res) {

	var user_fname = req.body.fname;
	var user_lname = req.body.lname;

	if (!user_fname) {
		return res.send("Subject first name is invalid");
	} else if (!user_lname) {
		return res.send("Subject last name is invalid");
	}

	User
		.find({
			fname: user_fname,
			lname: user_lname
		})
		.exec(function(err, users) {
			if (users.length > 0) {
				return res.send("User already exists");
			}

			var user_to_add = new User();

			user_to_add.fname = user_fname;
			user_to_add.lname = user_lname;
			user_to_add.locations = [];

			user_to_add.save(function(err) {
				if (err) return res.send("Could not create user " + err);
				res.json({
					message: "User " + user_fname + " " + user_lname + " created.",
					data: user_to_add._id
				});
			})
		});

}

exports.update_user_location = function(req, res) {

	var user_id = req.body.id;
	var user_latitude = req.body.latitude;
	var user_longitude = req.body.longitude;
	var user_time = req.body.time;
	var user_altitude = req.body.altitude;
	var user_speed = req.body.speed;
	var user_floor = req.body.floor;
	var user_horizontal_acc = req.body.horizontal_acc;
	var user_vertical_acc = req.body.vertical_acc;

	if (!user_id) {
		return res.send("Subject id was not sent"); 
	} else if (!user_latitude) {
		return res.send("Subject latitude was not sent");
	} else if (!user_longitude) {
		return res.send("Subject longitude was not sent");
	} else if (!user_time) {
		return res.send("Subject time was not sent");
	} else if (!user_altitude) {
		return res.send("Subject altitude was not sent");
	} else if (!user_speed) {
		return res.send("Subject speed was not sent");
	} else if (!user_floor) {
		return res.send("Subject floor was not sent");
	} else if (!user_horizontal_acc) {
		return res.send("Subject horizontal accuracy was not sent");
	} else if (!user_vertical_acc) {
		return res.send("Subject vertical accuracy was not sent");
	}

	var new_location = new Location();

	new_location.latitude = user_latitude;
	new_location.longitude = user_longitude;
	new_location.time = user_time;
	new_location.altitude = user_altitude;
	new_location.speed = user_speed;
	new_location.floor = user_floor;
	new_location.horizontal_acc = user_horizontal_acc;
	new_location.vertical_acc = user_vertical_acc;

	User
		.update({
			_id: user_id
		},
		{$push: {
			locations: new_location
		}},
		{
			upsert: false,
			multi: false
		},
		function(err, raw) {
			if (err) return res.send("There was an error updating the location " + err);
			res.json({
				message: "Location data successfully added"
			});
		});

}

