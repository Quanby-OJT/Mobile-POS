const express = require('express');
const multer = require('multer');
const sessionJWT = require('../middleware/userSession')
const InventoryController = require('../controllers/inventoryController');
const AuthenticationController = require('../controllers/authenticationController');

const router = express.Router();
const upload = multer({ storage: multer.memoryStorage() });

// Define routes
//router.post('/add-user', UserController.addUser);
//router.get('/all-users', UserController.getAllUsers);

router.get('/', (req, res) => {
    res.send('Hello. Whos this?')
})

router.post('/add-product', upload.single('image'), InventoryController.addProduct);
router.get('/all-products', InventoryController.getAllProducts);

router.post('/login-authentication', AuthenticationController.loginAuthentication)
router.post('/otp-authentication', AuthenticationController.otpAuthentication)
router.post('/user-session', sessionJWT, AuthenticationController.setSession)

module.exports = router;