const UserModel = require('../models/userModel');

class UserController {
    static async createUser(req, res) {
        try {
            const { name, email } = req.body;

            // Validation
            if (!name || !email) return res.status(400).json({ error: 'Name and email are required' });
            if (!email.includes('@')) return res.status(400).json({ error: 'Invalid email format, must have "@"' });
            if (!email.includes('.com')) return res.status(400).json({ error: 'Invalid email format, must have ".com"' });

            const userData = await UserModel.addUser(name, email);
            return res.status(201).json({ message: 'User added successfully', userData });
        } catch (error) {
            return res.status(500).json({ error: error.message + 'Error Has occured While Storing Data'});
        }
    }

    

    static async getAllUsers(req, res) {
        try {
            const users = await UserModel.getAllUsers(); // Fetch users from Supabase
            return res.status(200).json(users);
        } catch (error) {
            return res.status(500).json({ error: error.message });
        }
    }
}

module.exports = UserController;
