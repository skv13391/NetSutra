import Foundation

// Example usage of DatabaseManager singleton
class DatabaseUsageExample {
    
    static func demonstrateUsage() {
        let dbManager = DatabaseManager.shared
        
        // MARK: - Category Operations Example
        print("=== Category Operations ===")
        
        // Insert categories
        let category1Success = dbManager.insertCategory(catId: "CAT001", categoryName: "Electronics")
        let category2Success = dbManager.insertCategory(catId: "CAT002", categoryName: "Clothing")
        let category3Success = dbManager.insertCategory(catId: "CAT003", categoryName: "Books")
        
        print("Category insert results: \(category1Success), \(category2Success), \(category3Success)")
        
        // Get all categories
        let allCategories = dbManager.getAllCategories()
        print("All categories: \(allCategories)")
        
        // Get category by ID
        if let category = dbManager.getCategoryById(catId: "CAT001") {
            print("Found category: \(category)")
        }
        
        // Update category
        let updateSuccess = dbManager.updateCategory(catId: "CAT001", categoryName: "Electronics & Gadgets")
        print("Category update success: \(updateSuccess)")
        
        // MARK: - SubCategory Operations Example
        print("\n=== SubCategory Operations ===")
        
        // Insert subcategories
        let subCat1Success = dbManager.insertSubCategory(catId: "CAT001", subCatId: "SUB001", subCatName: "Smartphones")
        let subCat2Success = dbManager.insertSubCategory(catId: "CAT001", subCatId: "SUB002", subCatName: "Laptops")
        let subCat3Success = dbManager.insertSubCategory(catId: "CAT002", subCatId: "SUB003", subCatName: "Men's Clothing")
        
        print("SubCategory insert results: \(subCat1Success), \(subCat2Success), \(subCat3Success)")
        
        // Get all subcategories
        let allSubCategories = dbManager.getAllSubCategories()
        print("All subcategories: \(allSubCategories)")
        
        // Get subcategories by category ID
        let subCategoriesForCat1 = dbManager.getSubCategoriesByCategoryId(catId: "CAT001")
        print("Subcategories for CAT001: \(subCategoriesForCat1)")
        
        // Update subcategory
        let updateSubCatSuccess = dbManager.updateSubCategory(subCatId: "SUB001", subCatName: "Mobile Phones")
        print("SubCategory update success: \(updateSubCatSuccess)")
        
        // MARK: - CatDetails Operations Example
        print("\n=== CatDetails Operations ===")
        
        // Insert cat details
        let catDetail1Success = dbManager.insertCatDetails(
            catId: "CAT001",
            subCatId: "SUB001",
            categoryName: "Electronics & Gadgets",
            subCatName: "Mobile Phones",
            shipmentId: "SHIP001",
            shipmentName: "iPhone 15 Pro",
            shipmentDescription: "Latest iPhone with advanced features",
            mobility: "Mobile",
            userAccessGroup: "Premium Users",
            status: "Active"
        )
        
        let catDetail2Success = dbManager.insertCatDetails(
            catId: "CAT001",
            subCatId: "SUB002",
            categoryName: "Electronics & Gadgets",
            subCatName: "Laptops",
            shipmentId: "SHIP002",
            shipmentName: "MacBook Pro",
            shipmentDescription: "Professional laptop for developers",
            mobility: "Portable",
            userAccessGroup: "Developers",
            status: "Active"
        )
        
        print("CatDetails insert results: \(catDetail1Success), \(catDetail2Success)")
        
        // Get all cat details
        let allCatDetails = dbManager.getAllCatDetails()
        print("All cat details count: \(allCatDetails.count)")
        for detail in allCatDetails {
            print("Detail: \(detail.categoryName) - \(detail.subCatName) - \(detail.shipmentName ?? "N/A")")
        }
        
        // Get cat details by category ID
        let catDetailsForCat1 = dbManager.getCatDetailsByCategoryId(catId: "CAT001")
        print("CatDetails for CAT001 count: \(catDetailsForCat1.count)")
        
        // Update cat details (assuming we have the ID from the first record)
        if let firstDetail = allCatDetails.first {
            // Note: In a real scenario, you'd need to track the ID properly
            // This is just for demonstration
            print("First detail: \(firstDetail.categoryName) - \(firstDetail.shipmentName ?? "N/A")")
        }
        
        // MARK: - Cleanup Example (Optional)
        print("\n=== Cleanup Operations ===")
        
        // Delete operations (commented out to preserve data for demonstration)
        // let deleteCatDetailSuccess = dbManager.deleteCatDetails(id: 1)
        // let deleteSubCatSuccess = dbManager.deleteSubCategory(subCatId: "SUB001")
        // let deleteCatSuccess = dbManager.deleteCategory(catId: "CAT001")
        
        // print("Delete operations: \(deleteCatDetailSuccess), \(deleteSubCatSuccess), \(deleteCatSuccess)")
    }
    
    // MARK: - Helper Methods for UI Integration
    static func getCategoriesForPicker() -> [String] {
        let dbManager = DatabaseManager.shared
        let categories = dbManager.getAllCategories()
        return categories.map { $0.categoryName }
    }
    
    static func getSubCategoriesForCategory(_ catId: String) -> [String] {
        let dbManager = DatabaseManager.shared
        let subCategories = dbManager.getSubCategoriesByCategoryId(catId: catId)
        return subCategories.map { $0.subCatName }
    }
    
    static func searchCatDetails(byCategoryName categoryName: String) -> [CatDetailRecord] {
        let dbManager = DatabaseManager.shared
        let allDetails = dbManager.getAllCatDetails()
        return allDetails.filter { $0.categoryName.lowercased().contains(categoryName.lowercased()) }
    }
    
    static func searchCatDetails(byShipmentName shipmentName: String) -> [CatDetailRecord] {
        let dbManager = DatabaseManager.shared
        let allDetails = dbManager.getAllCatDetails()
        return allDetails.filter { 
            guard let name = $0.shipmentName else { return false }
            return name.lowercased().contains(shipmentName.lowercased())
        }
    }
}

// MARK: - Extension for CatDetailRecord
extension CatDetailRecord {
    var displayName: String {
        return "\(categoryName) - \(subCatName)"
    }
    
    var shipmentDisplayName: String {
        return shipmentName ?? "No Shipment Name"
    }
    
    var isActive: Bool {
        return status?.lowercased() == "active"
    }
}
