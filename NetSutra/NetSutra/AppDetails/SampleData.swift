//
//  SampleData.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

class SampleDataEntry {
    // MARK: - Sample Data Setup
     func setupSampleData() {
        let dbManager = DatabaseManager.shared
        
        // Check if data already exists
        let existingCategories = dbManager.getAllCategories()
        if !existingCategories.isEmpty {
            print("Database already contains data, skipping sample data creation")
            return
        }
        
        print("Setting up sample data...")
        
        // Create 6 main categories
        let categories = [
            ("CAT001", "Electronics"),
            ("CAT002", "Clothing"),
            ("CAT003", "Home & Garden"),
            ("CAT004", "Automotive"),
            ("CAT005", "Food"),
            ("CAT006", "Places")
        ]
        
        // Create categories
        for (catId, categoryName) in categories {
            let success = dbManager.insertCategory(catId: catId, categoryName: categoryName)
            print("Created category \(categoryName): \(success)")
        }
        
        // Create 7 subcategories for each category
        let subCategories = [
            // Electronics subcategories
            ("CAT001", "SUB001", "Smartphones"),
            ("CAT001", "SUB002", "Laptops"),
            ("CAT001", "SUB003", "Tablets"),
            ("CAT001", "SUB004", "Audio Devices"),
            ("CAT001", "SUB005", "Cameras"),
            ("CAT001", "SUB006", "Gaming Consoles"),
            ("CAT001", "SUB007", "Smart Home"),
            
            // Clothing subcategories
            ("CAT002", "SUB008", "Men's Clothing"),
            ("CAT002", "SUB009", "Women's Clothing"),
            ("CAT002", "SUB010", "Kids' Clothing"),
            ("CAT002", "SUB011", "Shoes"),
            ("CAT002", "SUB012", "Accessories"),
            ("CAT002", "SUB013", "Sportswear"),
            ("CAT002", "SUB014", "Formal Wear"),
            
            // Home & Garden subcategories
            ("CAT003", "SUB015", "Furniture"),
            ("CAT003", "SUB016", "Kitchen & Dining"),
            ("CAT003", "SUB017", "Bedding & Bath"),
            ("CAT003", "SUB018", "Garden Tools"),
            ("CAT003", "SUB019", "Outdoor Living"),
            ("CAT003", "SUB020", "Home Decor"),
            ("CAT003", "SUB021", "Lighting"),
            
            // Automotive subcategories
            ("CAT004", "SUB0022", "Cars"),
            ("CAT004", "SUB0023", "Bikes"),
            ("CAT004", "SUB0024", "Trucks"),
            ("CAT004", "SUB0025", "Accessories"),
            ("CAT004", "SUB0026", "Aircraft"),
            ("CAT004", "SUB0027", "Helocotor"),
            ("CAT004", "SUB0028", "JCB"),
            
            // Food subcategories
            ("CAT005", "SUB0029", "Bread"),
            ("CAT005", "SUB0030", "Coffee"),
            ("CAT005", "SUB0031", "Tea"),
            ("CAT005", "SUB0032", "Snacks"),
            ("CAT005", "SUB0033", "Burger"),
            ("CAT005", "SUB0034", "Pizza"),
            ("CAT005", "SUB0035", "Tacco"),
            
            // Places subcategories
            ("CAT006", "SUB0029", "Shimla"),
            ("CAT006", "SUB0030", "Shangrila"),
            ("CAT006", "SUB0031", "Patnitop"),
            ("CAT006", "SUB0032", "Temple"),
            ("CAT006", "SUB0033", "LongTrip"),
            ("CAT006", "SUB0034", "Jammu"),
            ("CAT006", "SUB0035", "Trackking"),
        ]
        
        // Create subcategories
        for (catId, subCatId, subCatName) in subCategories {
            let success = dbManager.insertSubCategory(catId: catId, subCatId: subCatId, subCatName: subCatName)
            print("Created subcategory \(subCatName): \(success)")
        }
        
        // Create 10 elements for each subcategory (210 total elements)
        createSampleElements(dbManager: dbManager)
        
        print("Sample data setup completed!")
    }
    
    private func createSampleElements(dbManager: DatabaseManager) {
        // Electronics elements
        createElectronicsElements(dbManager: dbManager)
        createClothingElements(dbManager: dbManager)
        createHomeGardenElements(dbManager: dbManager)
    }
    
    private func createElectronicsElements(dbManager: DatabaseManager) {
        let electronicsElements = [
            // Smartphones
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP001", "iPhone 15 Pro", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Premium Users", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP002", "Samsung Galaxy S24", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Premium Users", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP003", "Google Pixel 8", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Tech Enthusiasts", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP004", "OnePlus 12", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Power Users", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP005", "Xiaomi 14", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Budget Users", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP006", "Nothing Phone 2", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Design Enthusiasts", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP007", "ASUS ROG Phone", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Gamers", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP008", "Sony Xperia", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Photographers", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP009", "Motorola Edge", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "General Users", "Active"),
            ("CAT001", "SUB001", "Electronics", "Smartphones", "SHIP010", "Huawei P60", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Mobile", "Photography Lovers", "Active"),
            
            // Laptops
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP011", "MacBook Pro 16", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Developers", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP012", "Dell XPS 15", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Professionals", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP013", "Lenovo ThinkPad X1", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Business Users", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP014", "HP Spectre x360", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Creative Users", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP015", "ASUS ROG Strix", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Gamers", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP016", "MSI GS66", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Gamers", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP017", "Razer Blade 15", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Gamers", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP018", "Acer Swift 3", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Students", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP019", "Microsoft Surface", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Creative Users", "Active"),
            ("CAT001", "SUB002", "Electronics", "Laptops", "SHIP020", "LG Gram", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Portable", "Travelers", "Active")
        ]
        
        for element in electronicsElements {
            let success = dbManager.insertCatDetails(
                catId: element.0, subCatId: element.1, categoryName: element.2,
                subCatName: element.3, shipmentId: element.4, shipmentName: element.5,
                shipmentDescription: element.6, mobility: element.7, userAccessGroup: element.8, status: element.9
            )
            if success {
                print("Created element: \(element.5)")
            }
        }
    }
    
    private func createClothingElements(dbManager: DatabaseManager) {
        let clothingElements = [
            // Men's Clothing
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP021", "Classic Denim Jacket", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP022", "Premium Cotton T-Shirt", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. t", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP023", "Formal Business Suit", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Business Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP024", "Casual Hoodie", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP025", "Dress Shirt", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Formal Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP026", "Chino Pants", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP027", "Polo Shirt", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP028", "Sweater", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP029", "Jeans", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "General Users", "Active"),
            ("CAT002", "SUB008", "Clothing", "Men's Clothing", "SHIP030", "Blazer", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Fashion Users", "Active")
        ]
        
        for element in clothingElements {
            let success = dbManager.insertCatDetails(
                catId: element.0, subCatId: element.1, categoryName: element.2,
                subCatName: element.3, shipmentId: element.4, shipmentName: element.5,
                shipmentDescription: element.6, mobility: element.7, userAccessGroup: element.8, status: element.9
            )
            if success {
                print("Created element: \(element.5)")
            }
        }
    }
    
    private func createHomeGardenElements(dbManager: DatabaseManager) {
        let homeGardenElements = [
            // Furniture
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP031", "Modern Sofa", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP032", "Dining Table Set", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP033", "Bed Frame", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP034", "Coffee Table", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP035", "Bookshelf", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Book Lovers", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP036", "Wardrobe", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP037", "Office Desk", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Remote Workers", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP038", "TV Stand", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Home Owners", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP039", "Accent Chair", "The iPhone 15 Pro is built with aerospace-grade titanium, making it both durable and lightweight in hand. Powered by the new A17 Bionic chip, it delivers unmatched speed, energy efficiency, and next-generation gaming performance. Its 6.1-inch Super Retina XDR display with ProMotion technology ensures smoother scrolling, vibrant colors, and excellent brightness even under sunlight. The advanced triple-camera system allows you to capture professional-grade photos and 4K HDR cinematic videos with ease. ", "Stationary", "Interior Designers", "Active"),
            ("CAT003", "SUB015", "Home & Garden", "Furniture", "SHIP040", "Console Table", "Entryway organization", "Stationary", "Home Owners", "Active")
        ]
        
        for element in homeGardenElements {
            let success = dbManager.insertCatDetails(
                catId: element.0, subCatId: element.1, categoryName: element.2,
                subCatName: element.3, shipmentId: element.4, shipmentName: element.5,
                shipmentDescription: element.6, mobility: element.7, userAccessGroup: element.8, status: element.9
            )
            if success {
                print("Created element: \(element.5)")
            }
        }
    }
}
