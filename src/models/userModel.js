const supabase = require('../config/supabaseClient');

class UserModel {
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
    
    
    static async generateOTP(user_id) {
        let otp = Math.floor(100000 + Math.random() * 900000);

        // Extend the Date prototype to add minutes
        Date.prototype.addMins = function (m) {
            this.setTime(this.getTime() + m * 60 * 1000);
            return this;
        };

        let timestamp = new Date();

        // Check if user_id exists in the table
        const { data: existingRecord, error: fetchError } = await supabase
            .from('two_fa_code')
            .select('user_id')
            .eq('user_id', user_id)
            .single(); // Ensures we fetch only one record
        
        console.log({ data: existingRecord, error: fetchError });

        if (fetchError && fetchError.code !== 'PGRST116') { // Ignore "No rows found" error
            throw new Error(fetchError.message);
        }

        let response;

        if (existingRecord) {
            // If user_id exists, update two_fa_code and two_fa_code_expires_at
            console.log(existingRecord)
            const { data, error } = await supabase
                .from('two_fa_code')
                .update([{
                    two_fa_code: otp,
                    two_fa_code_expires_at: timestamp.addMins(3)
                }])
                .eq('user_id', user_id)


            if (error) throw new Error(error.message);
            console.log(data)

            response = data;
        } else {
            // If user_id does not exist, insert all data
            const { data, error } = await supabase
                .from('two_fa_code')
                .insert([{
                    user_id: user_id,
                    two_fa_code: otp,
                    two_fa_code_expires_at: timestamp.addMins(3),
                }]);

            if (error) throw new Error(error.message);

            response = data;
        }

        return { otp, data: response };
    }

    static async attemptOTPAuth(user_id)
    {
        const {data, error} = await supabase.from('two_fa_code').select('two_fa_code, two_fa_code_expires_at').eq('user_id', user_id).single()
        //console.log({ data, error }); // Log the response for debugging
    
        if (error) throw new Error(error.message || "An unknown database error occurred."); // Handle missing message

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
