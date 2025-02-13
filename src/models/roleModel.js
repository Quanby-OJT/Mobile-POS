const supabase = require('../config/supabaseClient');

class RoleModel {
    static async addRole(roleName) {
        const { data, error } = await supabase
            .from('roles')
            .insert([{ role_name: roleName }]);

        if (error) throw new Error(error.message);

        return data;
    }

    static async getRoles() {
        const { data, error } = await supabase
            .from('roles')
            .select('*');

        if (error) throw new Error(error.message);

        return data;
    }
}

module.exports = RoleModel;

module.exports = RoleModel;
