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

    static async attemptLoginAuth(email) {
        const {data, error} = await supabase.from('Users').select('email', 'activation', 'password', 'status').is('email', email)
        if (error) throw new error(error.message)
        return data;
    }
    
    static async generateOTP()
    {
        let otp = Math.floor(100000 + Math.random() * 900000);
        Date.prototype.addMins = function(m) {
            this.setTime(this.getTime() + (m * 60 * 100))
            return this
        }
        let timestamp = new Date()
        const { data, error } = await supabase.from('Users').insert([{ two_fa_code: otp, two_fa_code_expires: timestamp.addMins(2) }]);
        if (error) throw new Error(error.message);
        return {otp, data};
    }

    static async attemptOTPAuth(email)
    {
        const { data, error } = await supabase.from('Users').select('two_fa_code').in('email', email);
        if (error) throw new Error(error.message);
        return data;
    }
}

module.exports = UserModel;
