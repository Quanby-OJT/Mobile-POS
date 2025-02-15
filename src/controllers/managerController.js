const sharp = require("sharp");
const ManagerModel = require("../models/managerModel");

class ManagerController {
  static async addManager(req, res) {
    try {
      //   if (!req.file) {
      //     return res.status(400).json({ error: "No file uploaded" });
      //   }

      // Get additional data from Flutter
      const { name, last, middle, email, birthday } = req.body;

      if (!name || !last || !middle || !email || !birthday) {
        return res.status(400).json({ error: "Missing required fields" });
      }

      // Resize Image
      //   const resizedImage = await sharp(req.file.buffer)
      //     .resize(500, 500) // Resize to 500x500
      //     .toBuffer();

      //   const fileName = `uploads/${Date.now()}-${req.file.originalname}`;

      // Upload Image using Model
      //   const imageUrl = await InventoryModel.uploadImage(
      //     resizedImage,
      //     fileName,
      //     req.file.mimetype
      //   );

      // Insert Product using Model
      const dbData = await ManagerModel.insertManager(
        last,
        name,
        middle,
        email,
        birthday
      );

      res.json({
        message: "Image uploaded successfully",
        imageUrl,
        name,
        quantity,
        price,
        dbData,
      });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }

  static async getAllProducts(req, res) {
    try {
      const products = await InventoryModel.getAllProducts();
      res.json(products);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
}

module.exports = ManagerController;
