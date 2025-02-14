const expressJWT = require('express-jwt')

const sessionJWT = expressJWT({
    secret: process.env.JWT_SECRET,
    algorithms: ['HS256'],
    requestProperty: 'auth', // The decoded token will be attached to `req.auth`
  }).unless({
    path: ['/login', '/otp-authentication'], // Exclude paths that don't require authentication
  });
  
  module.exports = sessionJWT;