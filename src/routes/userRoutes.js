const express = require('express');
const UserController = require('../controllers/userController');
const AuthenticationController = require('../controllers/authenticationController')

const router = express.Router();

// Define routes
router.post('/add-user', UserController.addUser);
router.get('/all-users', UserController.getAllUsers);

router.post('/login-authentication', AuthenticationController.loginAuthentication)
router.post('/otp-authentication', AuthenticationController.otpAuthentication)

module.exports = router;
