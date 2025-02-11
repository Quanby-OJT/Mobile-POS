const UserModel = require('../models/userModel');
const mailer = require('../config/mailtrapClient');

class AuthenticationController {
    static async loginAuthentication(req, res) {
        try{
            const {email, password} = req.body

            //Validation Processing
            if(!email || !password) return res.status(400).json({error: "Email and/or password cannot be empty."})
            if (!email.includes('@')) return res.status(400).json({ error: 'Invalid email format, must have "@"' })
            if (!email.includes('.com')) return res.status(400).json({ error: 'Invalid email format, must have ".com"' })

            //Main Authentication
            const verify = await UserModel.attemptLoginAuth(email);

            if(!verify.status) return res.status(400).json({error: "Account is not active."})
            if(!verify.activation) return res.status(400).json({error: "Account is not verified."})

            if(verify.password !== req.body.password) {
                return res.status(400).json({error: "Incorrect password."})
            }
            //Code for Redirection and OTP Generation
            else{
                const otp = UserModel.generateOTP();
                return res.status(201).json({message: "Generating OTP....", verify})
            }
    
        }catch(error){
            return res.status(500).json({ error: error.message + 'An Error Occurred while Logging in.'});
        }
    }

    static async otpAuthentication(req, res) {
        try{
            const {otp} = req.body

            if(!otp) return res.status(400).json({error: "OTP Number Field cannot be empty"})

            const otp_verify = await UserModel.attemptOTPAuth(email)

            if(otp_verify.two_fa_code !== otp) return res.status(301).json({error: "OTP is Incorrect. Please Check Your Email."})
            if(otp_verify.two_fa_code_expires === Date.now()) return res.status(301).json({error: "OTP Verification Expired. Please Login again."})
            
            return res.status(200).json({message: "Successfully Verified OTP."})
        }catch(error){
            return res.status(500).json({ error: error.message + 'Error Has occurred While Authenticating OTP. Please Reload this page.'});
        }
    }
}

module.exports = AuthenticationController