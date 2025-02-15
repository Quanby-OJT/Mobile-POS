const express = require("express");
const multer = require("multer");
const managerController = require("../controllers/managerController");
const UserController = require("../controllers/userController");
const InventoryController = require("../controllers/inventoryController");
const AuthenticationController = require("../controllers/authenticationController");

const router = express.Router();
const upload = multer({ storage: multer.memoryStorage() });

router.post("/add-manager", managerController.addManager);
router.get("/fetch-manager", managerController.getAllProducts);

// router.post(
//   "/login-authentication",
//   AuthenticationController.loginAuthentication
// );
// router.post("/otp-authentication", AuthenticationController.otpAuthentication);

module.exports = router;
