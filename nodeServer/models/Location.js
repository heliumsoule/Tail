var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Location_Schema = new Schema({
	_id: false,

	latitude: Number,
	longitude: Number,
	time: String,
	altitude: Number,
	speed: String,
	floor: String,
	horizontal_acc: String,
	vertical_acc: String,
});

























module.exports = mongoose.model('Location', Location_Schema);