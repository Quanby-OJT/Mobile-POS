const supabase = require('../config/supabaseClient');

class UserModel {
    static async addUser(name, email) {
        const { data, error } = await supabase.from('user').insert([{ name, email }]);
        if (error) throw new Error(error.message);
        return data;
    }

    static async getAllUsers() {
        const { data, error } = await supabase.from('user').select('*');
        if (error) throw new Error(error.message);
        return data;
    }

    static async attemptLoginAuth(email, password) {
        const {data, error} = await supabase.from('Users').select('email', 'activation', 'password', 'status').is('email', email)
        if (error) throw new error(error.message)
        return data;
    }
    
    static async generateOTP()
    {
        let otp = Math.floor(100000 + Math.random() * 900000);
        const timestamp = new Date()
        const { data, error } = await supabase.from('Users').insert([{ two_fa_code: otp }]);
        if (error) throw new Error(error.message);
        return data;
    }

    static async attemptOTPAuth(email)
    {
        const { data, error } = await supabase.from('Users').select('two_fa_code').in('email', email);
        if (error) throw new Error(error.message);
        return data;
    }
}

module.exports = UserModel;
