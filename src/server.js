require("dotenv").config();
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const userRoutes = require("./routes/ApiRoutes");
var session = require('express-session')

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// API Routes
app.use("/api/connection", userRoutes);

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
