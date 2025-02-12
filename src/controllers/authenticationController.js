const UserModel = require('../models/userModel');
const mailer = require('../config/mailtrapClient');

class AuthenticationController {
    static async loginAuthentication(req, res) {
        try {
            const { email, password } = req.body;
    
            // Validation Processing
            if (!email || !password) {
                return res.status(400).json({ message: "Email and/or password cannot be empty." });
            }
            if (!email.includes('@')) {
                return res.status(400).json({ message: 'Invalid email format, must have "@"' });
            }
    
            // Main Authentication
            const verify = await UserModel.attemptLoginAuth(email);
            console.log(verify)

            if(!verify.email) return res.status(400).json({message: verify.toString()})
    
            if (verify.status) {
                return res.status(400).json({ message: "Account is not active." });
            }
            if (verify.activation) {
                return res.status(400).json({ message: "Account is not verified." });
            }           
    
            if (verify.password !== password) {
                return res.status(400).json({ message: "Incorrect password." });
            }
    
            // Code for Redirection and OTP Generation
            const otpResult = generateOTP()
            console.log(otpResult.otp); // Log the OTP for debugging purposes
    
            return res.status(200).json({ message: "Generating OTP....", verify });
    
        } catch (error) {
            console.error(error); // Log the error for debugging
            return res.status(500).json({ error: error.message || "An error occurred during login." });
        }
    }

    static async generateOTP () {
        return await userModel.generateOTP();
    }
    

    static async otpAuthentication(req, res) {
        try{
            console.log('Hello.')
            const {otp} = req.body

            if(!otp) return res.status(400).json({error: "OTP Number Field cannot be empty"})

            const otp_verify = await UserModel.attemptOTPAuth(email)

            if(otp_verify.two_fa_code !== otp) return res.status(301).json({error: "OTP is Incorrect. Please Check Your Email."})
            if(otp_verify.two_fa_code_expires === Date.now()) return res.status(301).json({error: "OTP Verification Expired. Please Login again."})
            
            return res.status(200).json({message: "Successfully Verified OTP."})
        }catch(error){
            console.error(error)
            return res.status(500).json({ error: 'Error Has occurred While Authenticating OTP. Please Reload this page.'});
        }
    }
}

module.exports = AuthenticationController