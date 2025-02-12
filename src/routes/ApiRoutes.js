const express = require('express');
const multer = require('multer');
const UserController = require('../controllers/userController');
const InventoryController = require('../controllers/inventoryController');
const AuthenticationController = require('../controllers/authenticationController');

const router = express.Router();
const upload = multer({ storage: multer.memoryStorage() });

// Define routes
router.post('/add-user', UserController.addUser);
router.get('/all-users', UserController.getAllUsers);

router.post('/add-product', upload.single('image'), InventoryController.addProduct);
router.get('/all-products', InventoryController.getAllProducts);

router.post('/login-authentication', AuthenticationController.loginAuthentication)
router.post('/otp-authentication', AuthenticationController.otpAuthentication)

module.exports = router;