const express = require('express');
const UserController = require('../controllers/userController');

const router = express.Router();

// Define routes
router.post('/add-user', UserController.addUser);
router.get('/all-users', UserController.getAllUsers);

module.exports = router;
