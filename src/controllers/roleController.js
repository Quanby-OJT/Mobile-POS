const RoleModel = require('../models/roleModel');

class RoleController {
    static async addRole(req, res) {
        try {
            const { roleName } = req.body;

            if (!roleName) {
                return res.status(400).json({ error: 'Role name is required' });
            }

            const data = await RoleModel.addRole(roleName);

            res.status(201).json({ message: 'Role added successfully', data });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    static async getRoles(req, res) {
        try {
            const data = await RoleModel.getRoles();

            res.status(200).json({ roles: data });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = RoleController;
