var express = require('express');

var user_controller = require('../controllers/user_controller');

var router = express.Router();

router.route('/user/create_user').post(user_controller.create_user);
router.route('/user/update_user_location').post(user_controller.update_user_location);



























module.exports = router;