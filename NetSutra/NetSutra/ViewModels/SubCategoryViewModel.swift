import Foundation
import Combine

// MARK: - SubCategory ViewModel
class SubCategoryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var subCategories: [SubCategoryModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let dbManager = DatabaseManager.shared
    private var currentCategoryId: String?
    
    // MARK: - Initialization
    init() {
        // Initialize without loading data
    }
    
    // MARK: - Public Methods
    
    /// Load subcategories for a specific category ID
    func loadSubCategories(for categoryId: String) {
        currentCategoryId = categoryId
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Get subcategories for the specific category
            let dbSubCategories = self.dbManager.getSubCategoriesByCategoryId(catId: categoryId)
            
            // Create simple subcategory models
            let subCategoryModels = dbSubCategories.map { dbSubCategory in
                SubCategoryModel(
                    subCatId: dbSubCategory.subCatId,
                    subCatName: dbSubCategory.subCatName
                )
            }
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.subCategories = subCategoryModels
                self.isLoading = false
            }
        }
    }
    
    /// Refresh subcategories for the current category
    func refreshSubCategories() {
        guard let categoryId = currentCategoryId else { return }
        loadSubCategories(for: categoryId)
    }
    
    /// Get total subcategory count
    var totalSubCategoryCount: Int {
        return subCategories.count
    }
    
    /// Get current category ID
    var getCurrentCategoryId: String? {
        return currentCategoryId
    }
}
