# NetSutra SQLite Database Manager

A singleton class for managing SQLite database operations with three related tables: Category, SubCategory, and CatDetails.

## Database Schema

### 1. Category Table
- `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
- `cat_id` (TEXT UNIQUE NOT NULL)
- `categoryName` (TEXT NOT NULL)

### 2. SubCategory Table
- `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
- `cat_id` (TEXT NOT NULL) - Foreign key to Category.cat_id
- `subCat_id` (TEXT UNIQUE NOT NULL)
- `subCatName` (TEXT NOT NULL)

### 3. CatDetails Table
- `id` (INTEGER PRIMARY KEY AUTOINCREMENT)
- `cat_id` (TEXT NOT NULL) - Foreign key to Category.cat_id
- `subCat_id` (TEXT NOT NULL) - Foreign key to SubCategory.subCat_id
- `categoryName` (TEXT NOT NULL)
- `subCatName` (TEXT NOT NULL)
- `ShipmentID` (TEXT)
- `ShipmentName` (TEXT)
- `ShipmentDescription` (TEXT)
- `Mobility` (TEXT)
- `UserAccessGroup` (TEXT)
- `Status` (TEXT)

## Usage

### Getting the Singleton Instance
```swift
let dbManager = DatabaseManager.shared
```

### Category Operations

#### Insert a Category
```swift
let success = dbManager.insertCategory(catId: "CAT001", categoryName: "Electronics")
```

#### Get All Categories
```swift
let categories = dbManager.getAllCategories()
// Returns: [(catId: String, categoryName: String)]
```

#### Get Category by ID
```swift
if let category = dbManager.getCategoryById(catId: "CAT001") {
    print("Category: \(category.categoryName)")
}
```

#### Update Category
```swift
let success = dbManager.updateCategory(catId: "CAT001", categoryName: "Electronics & Gadgets")
```

#### Delete Category
```swift
let success = dbManager.deleteCategory(catId: "CAT001")
```

### SubCategory Operations

#### Insert a SubCategory
```swift
let success = dbManager.insertSubCategory(catId: "CAT001", subCatId: "SUB001", subCatName: "Smartphones")
```

#### Get All SubCategories
```swift
let subCategories = dbManager.getAllSubCategories()
// Returns: [(catId: String, subCatId: String, subCatName: String)]
```

#### Get SubCategories by Category ID
```swift
let subCategories = dbManager.getSubCategoriesByCategoryId(catId: "CAT001")
// Returns: [(subCatId: String, subCatName: String)]
```

#### Update SubCategory
```swift
let success = dbManager.updateSubCategory(subCatId: "SUB001", subCatName: "Mobile Phones")
```

#### Delete SubCategory
```swift
let success = dbManager.deleteSubCategory(subCatId: "SUB001")
```

### CatDetails Operations

#### Insert CatDetails
```swift
let success = dbManager.insertCatDetails(
    catId: "CAT001",
    subCatId: "SUB001",
    categoryName: "Electronics",
    subCatName: "Smartphones",
    shipmentId: "SHIP001",
    shipmentName: "iPhone 15 Pro",
    shipmentDescription: "Latest iPhone with advanced features",
    mobility: "Mobile",
    userAccessGroup: "Premium Users",
    status: "Active"
)
```

#### Get All CatDetails
```swift
let catDetails = dbManager.getAllCatDetails()
// Returns: [CatDetailRecord]
```

#### Get CatDetails by Category ID
```swift
let catDetails = dbManager.getCatDetailsByCategoryId(catId: "CAT001")
// Returns: [CatDetailRecord]
```

#### Update CatDetails
```swift
let success = dbManager.updateCatDetails(
    id: 1,
    shipmentId: "SHIP001_UPDATED",
    shipmentName: "iPhone 15 Pro Max",
    shipmentDescription: "Updated description",
    mobility: "Mobile",
    userAccessGroup: "Premium Users",
    status: "Active"
)
```

#### Delete CatDetails
```swift
let success = dbManager.deleteCatDetails(id: 1)
```

## Data Models

### CatDetailRecord
```swift
struct CatDetailRecord {
    let id: Int?
    let catId: String
    let subCatId: String
    let categoryName: String
    let subCatName: String
    let shipmentId: String?
    let shipmentName: String?
    let shipmentDescription: String?
    let mobility: String?
    let userAccessGroup: String?
    let status: String?
}
```

### CatDetailRecord Extensions
```swift
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
```

## Example Usage

### Basic Setup
```swift
class MyViewController: UIViewController {
    private let dbManager = DatabaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatabase()
    }
    
    private func setupDatabase() {
        // Database is automatically initialized when accessed
        print("Database ready")
    }
}
```

### Sample Data Operations
```swift
// Add sample data
let sampleCategories = [
    ("CAT001", "Electronics"),
    ("CAT002", "Clothing"),
    ("CAT003", "Books")
]

for (catId, categoryName) in sampleCategories {
    dbManager.insertCategory(catId: catId, categoryName: categoryName)
}

// Add subcategories
dbManager.insertSubCategory(catId: "CAT001", subCatId: "SUB001", subCatName: "Smartphones")
dbManager.insertSubCategory(catId: "CAT001", subCatId: "SUB002", subCatName: "Laptops")

// Add cat details
dbManager.insertCatDetails(
    catId: "CAT001",
    subCatId: "SUB001",
    categoryName: "Electronics",
    subCatName: "Smartphones",
    shipmentId: "SHIP001",
    shipmentName: "iPhone 15 Pro",
    shipmentDescription: "Latest iPhone",
    mobility: "Mobile",
    userAccessGroup: "Premium Users",
    status: "Active"
)
```

### Search and Filter Operations
```swift
// Get all categories for a picker
let categories = dbManager.getAllCategories()
let categoryNames = categories.map { $0.categoryName }

// Get subcategories for a specific category
let subCategories = dbManager.getSubCategoriesByCategoryId(catId: "CAT001")

// Get cat details for a category
let catDetails = dbManager.getCatDetailsByCategoryId(catId: "CAT001")

// Search cat details by category name
let allDetails = dbManager.getAllCatDetails()
let filteredDetails = allDetails.filter { 
    $0.categoryName.lowercased().contains("electronics")
}
```

## Features

- **Singleton Pattern**: Ensures only one database instance exists
- **Automatic Table Creation**: Tables are created automatically when the database is initialized
- **Foreign Key Relationships**: Proper relationships between tables
- **CRUD Operations**: Complete Create, Read, Update, Delete operations for all tables
- **Error Handling**: Proper error handling and return values
- **Memory Management**: Automatic database cleanup in deinit
- **Thread Safety**: Safe for use across different threads

## File Structure

```
NetSutra/
├── DatabaseManager.swift          # Main singleton class
├── DatabaseUsageExample.swift     # Usage examples and helper methods
├── ViewController.swift           # UI demonstration
└── ...
```

## Requirements

- iOS 12.0+
- Swift 5.0+
- Xcode 12.0+

## Installation

1. Add `DatabaseManager.swift` to your Xcode project
2. Import the file in your view controllers
3. Use `DatabaseManager.shared` to access the singleton instance

## Notes

- The database file is stored in the app's documents directory
- Tables are created automatically on first access
- Foreign key constraints are enforced
- All string operations use proper SQLite binding to prevent SQL injection
- The database is automatically closed when the app terminates
