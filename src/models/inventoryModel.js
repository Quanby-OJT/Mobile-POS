const supabase = require('../config/supabaseClient');

class InventoryModel {

    static async uploadImage(fileBuffer, fileName, fileMimeType) {
        try {
            const { data, error } = await supabase.storage.from('images').upload(fileName, fileBuffer, {
                contentType: fileMimeType,
            });

            if (error) throw error;

            // Get the public URL
            const { data: publicUrlData } = supabase.storage.from('images').getPublicUrl(fileName);
            return publicUrlData.publicUrl;
        } catch (err) {
            throw new Error(`Error uploading image: ${err.message}`);
        }
    }

    static async insertProduct(imageUrl, name, quantity, price) {
        try {
            const { data, error } = await supabase
                .from('image_uploads')
                .insert([{ image_url: imageUrl, name, quantity, price }]);

            if (error) throw error;
            return data;
        } catch (err) {
            throw new Error(`Error inserting product: ${err.message}`);
        }
    }

    static async getAllProducts() {
        const { data, error } = await supabase.from('image_uploads').select('*');
    
        if (error) {
            console.error("Error fetching products:", error.message);
            return [];
        }
    
        return data || [];
    }
}

module.exports = InventoryModel;
