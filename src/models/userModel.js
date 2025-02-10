const supabase = require('../config/supabaseClient');

class UserModel {
    static async addUser(name, email) {
        const { data, error } = await supabase.from('users').insert([{ name, email }]);
        if (error) throw new Error(error.message);
        return data;
    }

    static async getAllUsers() {
        const { data, error } = await supabase.from('users').select('*');
        if (error) throw new Error(error.message);
        return data;
    }
    
}

module.exports = UserModel;
