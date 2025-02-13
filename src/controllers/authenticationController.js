const UserModel = require('../models/userModel')
const mailer = require('../config/mailtrapClient')
const bcrypt = require('bcrypt')

/**
 * For Debugging some logic, uncomment console.log and/or console.error to view errors easily. If you can't debug it, increment the following:
 * 
 * Hours Wasted debugging = 0.
 */
class AuthenticationController {
    static async loginAuthentication(req, res) {
        try {
            const { email, password } = req.body;
            console.log({ email, password });

            // Validation Processing
            if (!email || !password) {
                return res.status(400).json({ message: "Email and/or password cannot be empty." });
            }
            if (!email.includes('@')) {
                return res.status(400).json({ message: 'Invalid email format, must have "@"' });
            }

            // Main Authentication
            const verify = await UserModel.attemptLoginAuth(email);

            if(!verify.email) return res.status(400).json({message: verify.toString()})

            if (!verify.status) {
                return res.status(400).json({ message: "Account is not active." });
            }
            if (!verify.activation) {
                return res.status(400).json({ message: "Account is not verified." });
            }

            if (!(await bcrypt.compare(password, verify.password))){
                return res.status(400).json({ message: 'Incorrect Password. Please Try Again.' });
            }
            // Code for Redirection and OTP Generation
            const otpResult = await UserModel.generateOTP(verify.user_id)
            console.log(otpResult.otp); // Log the OTP for debugging purposes

            const message = "To access the application, you need to enter the following OTP: " + otpResult.otp + ". Once you are logged in, please delete this email to prevent unauthorized access to your account. \n NOTE: The generated OTP will be only valid at maximum of 3 minutes."

            const mailOptions = {
                from: process.env.SENDER_EMAIL,
                to: `${email}`,
                subject: "Your Login OTP Authentication",
                text: message
            }

            const info = await mailer.sendMail(mailOptions);
            console.log('Email Sent: ', info.response);

            return res.status(200).json({ user_id: verify.user_id, message: "Generating OTP..." });

        } catch (error) {
            console.error(error); // Log the error for debugging
            return res.status(500).json({ error: error.message || "An error occurred during login." });
        }
    }

    static async generateOTP () {
        console.log('Hi')
        // Code for Redirection and OTP Generation
        const otpResult = await UserModel.generateOTP(verify.user_id)
        console.log(otpResult.otp); // Log the OTP for debugging purposes
        const message = "<p>To access the application, you need to enter the following OTP: <span class='inline-block text-2xl>" + otpResult.otp +  ".</span> Once you are logged in, please delete this email to prevent unauthorized access to your account. NOTE: The generated OTP will be only valid at maximum of 3 minutes.</p>"
        const mailOptions = {
            from: process.env.SENDER_EMAIL,
            to: `${email}`,
            subject: "Your Login OTP Authentication",
            text: message
        }
        const info = await mailer.sendMail(mailOptions);
        console.log('Email Sent: ', info.response);

        return res.status(200).json({ message: "Generating OTP....", verify });
    }


    static async otpAuthentication(req, res) {
        try{
            //console.log('Hello.')
            const {otp, user_id} = req.body

            if(!otp) return res.status(400).json({message: "OTP Number Field cannot be empty"})

            const otp_verify = await UserModel.attemptOTPAuth(user_id)
            //console.log(otp_verify)

            if(otp_verify.two_fa_code !== otp) return res.status(301).json({error: "OTP is Incorrect. Please Check Your Email."})
            if(new Date(otp_verify.two_fa_code_expires_at).getTime() <= Date.now()){
                await UserModel.resetOtp(user_id)
                return res.status(301).json({error: "OTP Verification Expired. Please Login again."})
            }
            
            await UserModel.resetOTPAuth(user_id)
            const authenticatedUser = await UserModel.userSession(user_id);
            return res.status(200).json({role: authenticatedUser.roles.user_roles, user: user_id})
        }catch(error){
            //console.error(error)
            return res.status(500).json({ message: 'Error Has occurred While Authenticating OTP. Please Reload this page.'});
        }
    }
}

module.exports = AuthenticationController