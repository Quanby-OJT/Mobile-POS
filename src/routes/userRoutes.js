const express = require('express');
const AuthenticationController = require('../controllers/authenticationController')

const router = express.Router();

// Define routes
//router.post('/add-user', UserController.addUser);
//router.get('/all-users', UserController.getAllUsers);

router.get('/', (req, res) => {
    res.send('Hello. Whos this?')
})

router.post('/login-authentication', AuthenticationController.loginAuthentication)
router.post('/otp-authentication', AuthenticationController.otpAuthentication)

module.exports = router;
