import Foundation

// MARK: - Simple Category Model
struct CategoryModel {
    let catId: String
    let categoryName: String
    
    init(catId: String, categoryName: String) {
        self.catId = catId
        self.categoryName = categoryName
    }
}

// MARK: - SubCategory Model
struct SubCategoryModel {
    let subCatId: String
    let subCatName: String
    let elementCount: Int
    
    init(subCatId: String, subCatName: String, elementCount: Int = 0) {
        self.subCatId = subCatId
        self.subCatName = subCatName
        self.elementCount = elementCount
    }
}

// MARK: - Category Detail Model
struct CategoryDetailModel {
    let id: Int?
    let catId: String?
    let subCatId: String?
    let shipmentId: String?
    let shipmentName: String?
    let shipmentDescription: String?
    let mobility: String?
    let userAccessGroup: String?
    let status: String?
    
    init(id: Int,catId: String,subCatId : String, shipmentId: String?, shipmentName: String?, shipmentDescription: String?, mobility: String?, userAccessGroup: String?, status: String?) {
        self.id = id
        self.catId = catId
        self.subCatId  = subCatId
        self.shipmentId = shipmentId
        self.shipmentName = shipmentName
        self.shipmentDescription = shipmentDescription
        self.mobility = mobility
        self.userAccessGroup = userAccessGroup
        self.status = status
    }
}

// MARK: - Category Section Model (for grouped display)
struct CategorySectionModel {
    let category: CategoryModel
    let subCategories: [SubCategoryModel]
    let details: [CategoryDetailModel]
    
    init(category: CategoryModel, subCategories: [SubCategoryModel], details: [CategoryDetailModel]) {
        self.category = category
        self.subCategories = subCategories
        self.details = details
    }
}
