const supabase = require("../config/supabaseClient");

class ManagerModel {
  //   static async uploadImage(fileBuffer, fileName, fileMimeType) {
  //     try {
  //       const { data, error } = await supabase.storage
  //         .from("product_bucket")
  //         .upload(fileName, fileBuffer, {
  //           contentType: fileMimeType,
  //         });

  //       if (error) throw error;

  //       // Get the public URL
  //       const { data: publicUrlData } = supabase.storage
  //         .from("product_bucket")
  //         .getPublicUrl(fileName);
  //       return publicUrlData.publicUrl;
  //     } catch (err) {
  //       throw new Error(`Error uploading image: ${err.message}`);
  //     }
  //   }

  static async insertManager(last, name, email, middle, birthday) {
    try {
      const { data, error } = await supabase
        .from("user")
        .insert([{ image_url: imageUrl, name, last, email, middle, birthday }]);

      if (error) throw error;
      return data;
    } catch (err) {
      throw new Error(`Error inserting product: ${err.message}`);
    }
  }

  //   static async getAllProducts() {
  //     const { data, error } = await supabase.from("product").select("*");

  //     if (error) {
  //       console.error("Error fetching products:", error.message);
  //       return [];
  //     }

  //     return data || [];
  //   }
}

module.exports = ManagerModel;
