const supabase = require('../config/supabaseClient');

class UserModel {
    //static async addUser(name, email) {
    //    const { data, error } = await supabase.from('user').insert([{ name, email }]);
    //    if (error) throw new Error(error);
    //    return data;
    //}
//
    //static async getAllUsers() {
    //    const { data, error } = await supabase.from('user').select('*');
    //    if (error) throw new Error(error);
    //    return data;
    //}

    static async attemptLoginAuth(email) {
        //console.log(email)
        const { data, error } = await supabase
            .from('users')
            .select('user_id, email, activation, password, status')
            .eq('email', email);

        //console.log({ data, error }); // Log the response for debugging
    
        if (error) {
            throw new Error(error.message || "An unknown database error occurred."); // Handle missing message
        }
        if (!data || data.length === 0) {
            return "This email is not registered to our system. Please ask the admin for assistance."; // Handle the case where no user is found
        }
    
        return data[0]; // Return the first matched user (assuming emails are unique)
    }
    
    
    static async generateOTP(user_id)
    {
        let otp = Math.floor(100000 + Math.random() * 900000);
        Date.prototype.addMins = function(m) {
            this.setTime(this.getTime() + (m * 60 * 100))
            return this
        }
        let timestamp = new Date()
        const { data, error } = await supabase.from('two_fa_code').insert([{ user_id: user_id, two_fa_code: otp, two_fa_code_expires_at: timestamp.addMins(3) }]);
        if (error) throw new Error(error.message);

        return {otp, data};
    }

    static async attemptOTPAuth(code)
    {
        const { data, error } = await supabase.from('two_fa_code').select('two_fa_code').eq('two_fa_code', code);
        console.log({ data, error }); // Log the response for debugging
        if (error) throw new Error(error.message);
        return data;
    }

    static async resetOTPAuth()
    {
        const { data, error } = await supabase.from('two_fa_code').insert([{ two_fa_code: null, two_fa_code_expires_at: null }]);
        console.log({ data, error }); // Log the response for debugging
        if (error) throw new Error(error.message);
    }
}

module.exports = UserModel;
