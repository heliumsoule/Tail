var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Location_Schema = require('./Location.js').schema;

var User_Schema = new Schema({
	fname: String,
	lname: String,
	locations: [Location_Schema]
});





























module.exports = mongoose.model('User', User_Schema);