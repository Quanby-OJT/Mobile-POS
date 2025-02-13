const express = require('express');
const RoleController = require('../controllers/roleController');

const router = express.Router();

// Define routes
router.post('/change-role', RoleController.addRole);
router.get('/select-role', RoleController.getRoles);


module.exports = router;
