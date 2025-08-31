import Foundation
import Combine

// MARK: - Category ViewModel
class CategoryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var categories: [CategoryModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let dbManager = DatabaseManager.shared
    
    // MARK: - Initialization
    init() {
        loadCategories()
    }
    
    // MARK: - Public Methods
    
    /// Load all categories from database
    func loadCategories() {
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Get all categories from database
            let dbCategories = self.dbManager.getAllCategories()
            
            // Create simple category models
            let categoryModels = dbCategories.enumerated().map { index, dbCategory in
                CategoryModel(
                    catId: dbCategory.catId,
                    categoryName: dbCategory.categoryName
                )
            }
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.categories = categoryModels
                self.isLoading = false
            }
        }
    }
    
    /// Refresh categories data
    func refreshCategories() {
        loadCategories()
    }
    
    /// Get total category count
    var totalCategoryCount: Int {
        return categories.count
    }
}
