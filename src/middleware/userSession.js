const { expressjwt } = require('express-jwt'); // Import expressjwt from express-jwt

// Define the JWT middleware
const sessionJWT = expressjwt({
  secret: process.env.JWT_SECRET, // The secret key for signing tokens
  algorithms: ['HS256'], // Specify the algorithm used for signing
  requestProperty: 'auth', // Attach the decoded token to req.auth
});

// Exclude paths manually
const jwtMiddleware = (req, res, next) => {
  const excludedPaths = ['/login', '/otp-authentication'];

  // Skip JWT middleware for excluded paths
  if (excludedPaths.includes(req.path)) {
    return next();
  }

  // Run the JWT middleware for all other paths
  sessionJWT(req, res, next);
};

module.exports = jwtMiddleware;
