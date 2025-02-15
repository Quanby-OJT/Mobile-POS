const supabase = require('../config/supabaseClient');

class InventoryModel {

    static async uploadImage(fileBuffer, fileName, fileMimeType) {
        try {
            const { data, error } = await supabase.storage.from('product_bucket').upload(fileName, fileBuffer, {
                contentType: fileMimeType,
            });

            if (error) throw error;

            // Get the public URL
            const { data: publicUrlData } = supabase.storage.from('product_bucket').getPublicUrl(fileName);
            return publicUrlData.publicUrl;
        } catch (err) {
            throw new Error(`Error uploading image: ${err.message}`);
        }
    }

    static async insertProduct(imageUrl, name, quantity, price, category) {
        try {
            const { data, error } = await supabase
                .from('product')
                .insert([{ image_url: imageUrl, name, quantity, price, category }]);

            if (error) throw error;
            return data;
        } catch (err) {
            throw new Error(`Error inserting product: ${err.message}`);
        }
    }

    static async getAllProducts() {
        const { data, error } = await supabase
            .from('product')
            .select(`
                id, 
                name, 
                created_at, 
                quantity, 
                price, 
                product_status, 
                image_url, 
                ingredients_id, 
                discount, 
                categories:category_id(category) 
            `)
            .order('created_at', { ascending: false }); 
        
        if (error) {
            console.error("Error fetching products:", error.message);
            return [];
        }
    
        return data || [];
    }    
}

module.exports = InventoryModel;
