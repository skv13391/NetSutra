import Foundation
import SQLite3

class DatabaseManager {
    static let shared = DatabaseManager()
    private var database: OpaquePointer?
    
    // Database file name
    private let databaseName = "NetSutraDB.sqlite"
    
    private init() {
        setupDatabase()
    }
    
    // MARK: - Database Setup
    private func setupDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(databaseName)
        
        if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
            print("Error opening database")
            return
        }
        
        createTables()
    }
    
    private func createTables() {
        // Create Category table
        let createCategoryTable = """
            CREATE TABLE IF NOT EXISTS Category (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                cat_id TEXT UNIQUE NOT NULL,
                categoryName TEXT NOT NULL
            );
        """
        
        // Create SubCategory table
        let createSubCategoryTable = """
            CREATE TABLE IF NOT EXISTS SubCategory (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                cat_id TEXT NOT NULL,
                subCat_id TEXT UNIQUE NOT NULL,
                subCatName TEXT NOT NULL,
                FOREIGN KEY (cat_id) REFERENCES Category (cat_id)
            );
        """
        
        // Create CatDetails table
        let createCatDetailsTable = """
            CREATE TABLE IF NOT EXISTS CatDetails (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                cat_id TEXT NOT NULL,
                subCat_id TEXT NOT NULL,
                categoryName TEXT NOT NULL,
                subCatName TEXT NOT NULL,
                ShipmentID TEXT,
                ShipmentName TEXT,
                ShipmentDescription TEXT,
                Mobility TEXT,
                UserAccessGroup TEXT,
                Status TEXT,
                FOREIGN KEY (cat_id) REFERENCES Category (cat_id),
                FOREIGN KEY (subCat_id) REFERENCES SubCategory (subCat_id)
            );
        """
        
        if sqlite3_exec(database, createCategoryTable, nil, nil, nil) != SQLITE_OK {
            print("Error creating Category table")
        }
        
        if sqlite3_exec(database, createSubCategoryTable, nil, nil, nil) != SQLITE_OK {
            print("Error creating SubCategory table")
        }
        
        if sqlite3_exec(database, createCatDetailsTable, nil, nil, nil) != SQLITE_OK {
            print("Error creating CatDetails table")
        }
    }
    
    // MARK: - Category Operations
    func insertCategory(catId: String, categoryName: String) -> Bool {
        let insertStatement = "INSERT INTO Category (cat_id, categoryName) VALUES (?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (categoryName as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func getAllCategories() -> [(catId: String, categoryName: String)] {
        var categories: [(catId: String, categoryName: String)] = []
        let queryStatement = "SELECT cat_id, categoryName FROM Category"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let catId = String(cString: sqlite3_column_text(statement, 0))
                let categoryName = String(cString: sqlite3_column_text(statement, 1))
                categories.append((catId: catId, categoryName: categoryName))
            }
        }
        sqlite3_finalize(statement)
        return categories
    }
    
    func getCategoryById(catId: String) -> (catId: String, categoryName: String)? {
        let queryStatement = "SELECT cat_id, categoryName FROM Category WHERE cat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_ROW {
                let catId = String(cString: sqlite3_column_text(statement, 0))
                let categoryName = String(cString: sqlite3_column_text(statement, 1))
                sqlite3_finalize(statement)
                return (catId: catId, categoryName: categoryName)
            }
        }
        sqlite3_finalize(statement)
        return nil
    }
    
    func updateCategory(catId: String, categoryName: String) -> Bool {
        let updateStatement = "UPDATE Category SET categoryName = ? WHERE cat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, updateStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (categoryName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (catId as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func deleteCategory(catId: String) -> Bool {
        let deleteStatement = "DELETE FROM Category WHERE cat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, deleteStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    // MARK: - SubCategory Operations
    func insertSubCategory(catId: String, subCatId: String, subCatName: String) -> Bool {
        let insertStatement = "INSERT INTO SubCategory (cat_id, subCat_id, subCatName) VALUES (?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (subCatId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (subCatName as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func getAllSubCategories() -> [(catId: String, subCatId: String, subCatName: String)] {
        var subCategories: [(catId: String, subCatId: String, subCatName: String)] = []
        let queryStatement = "SELECT cat_id, subCat_id, subCatName FROM SubCategory"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let catId = String(cString: sqlite3_column_text(statement, 0))
                let subCatId = String(cString: sqlite3_column_text(statement, 1))
                let subCatName = String(cString: sqlite3_column_text(statement, 2))
                subCategories.append((catId: catId, subCatId: subCatId, subCatName: subCatName))
            }
        }
        sqlite3_finalize(statement)
        return subCategories
    }
    
    func getSubCategoriesByCategoryId(catId: String) -> [(subCatId: String, subCatName: String)] {
        var subCategories: [(subCatId: String, subCatName: String)] = []
        let queryStatement = "SELECT subCat_id, subCatName FROM SubCategory WHERE cat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let subCatId = String(cString: sqlite3_column_text(statement, 0))
                let subCatName = String(cString: sqlite3_column_text(statement, 1))
                subCategories.append((subCatId: subCatId, subCatName: subCatName))
            }
        }
        sqlite3_finalize(statement)
        return subCategories
    }
    
    func updateSubCategory(subCatId: String, subCatName: String) -> Bool {
        let updateStatement = "UPDATE SubCategory SET subCatName = ? WHERE subCat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, updateStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (subCatName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (subCatId as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func deleteSubCategory(subCatId: String) -> Bool {
        let deleteStatement = "DELETE FROM SubCategory WHERE subCat_id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, deleteStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (subCatId as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    // MARK: - CatDetails Operations
    func insertCatDetails(catId: String, subCatId: String, categoryName: String, subCatName: String,
                         shipmentId: String?, shipmentName: String?, shipmentDescription: String?,
                         mobility: String?, userAccessGroup: String?, status: String?) -> Bool {
        let insertStatement = """
            INSERT INTO CatDetails (cat_id, subCat_id, categoryName, subCatName, ShipmentID, 
                                  ShipmentName, ShipmentDescription, Mobility, UserAccessGroup, Status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (subCatId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (categoryName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (subCatName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (shipmentId as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, (shipmentName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 7, (shipmentDescription as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 8, (mobility as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 9, (userAccessGroup as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 10, (status as NSString?)?.utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func getAllCatDetails() -> [CatDetailRecord] {
        var catDetails: [CatDetailRecord] = []
        let queryStatement = """
            SELECT cat_id, subCat_id, categoryName, subCatName, ShipmentID, ShipmentName,
                   ShipmentDescription, Mobility, UserAccessGroup, Status
            FROM CatDetails
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let catDetail = CatDetailRecord(
                    catId: String(cString: sqlite3_column_text(statement, 0)),
                    subCatId: String(cString: sqlite3_column_text(statement, 1)),
                    categoryName: String(cString: sqlite3_column_text(statement, 2)),
                    subCatName: String(cString: sqlite3_column_text(statement, 3)),
                    shipmentId: sqlite3_column_text(statement, 4) != nil ? String(cString: sqlite3_column_text(statement, 4)) : nil,
                    shipmentName: sqlite3_column_text(statement, 5) != nil ? String(cString: sqlite3_column_text(statement, 5)) : nil,
                    shipmentDescription: sqlite3_column_text(statement, 6) != nil ? String(cString: sqlite3_column_text(statement, 6)) : nil,
                    mobility: sqlite3_column_text(statement, 7) != nil ? String(cString: sqlite3_column_text(statement, 7)) : nil,
                    userAccessGroup: sqlite3_column_text(statement, 8) != nil ? String(cString: sqlite3_column_text(statement, 8)) : nil,
                    status: sqlite3_column_text(statement, 9) != nil ? String(cString: sqlite3_column_text(statement, 9)) : nil
                )
                catDetails.append(catDetail)
            }
        }
        sqlite3_finalize(statement)
        return catDetails
    }
    
    func getCatDetailsByCategoryId(catId: String) -> [CatDetailRecord] {
        var catDetails: [CatDetailRecord] = []
        let queryStatement = """
            SELECT cat_id, subCat_id, categoryName, subCatName, ShipmentID, ShipmentName,
                   ShipmentDescription, Mobility, UserAccessGroup, Status
            FROM CatDetails WHERE cat_id = ?
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, queryStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (catId as NSString).utf8String, -1, nil)
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let catDetail = CatDetailRecord(
                     catId: String(cString: sqlite3_column_text(statement, 0)),
                    subCatId: String(cString: sqlite3_column_text(statement, 1)),
                    categoryName: String(cString: sqlite3_column_text(statement, 2)),
                    subCatName: String(cString: sqlite3_column_text(statement, 3)),
                    shipmentId: sqlite3_column_text(statement, 4) != nil ? String(cString: sqlite3_column_text(statement, 4)) : nil,
                    shipmentName: sqlite3_column_text(statement, 5) != nil ? String(cString: sqlite3_column_text(statement, 5)) : nil,
                    shipmentDescription: sqlite3_column_text(statement, 6) != nil ? String(cString: sqlite3_column_text(statement, 6)) : nil,
                    mobility: sqlite3_column_text(statement, 7) != nil ? String(cString: sqlite3_column_text(statement, 7)) : nil,
                    userAccessGroup: sqlite3_column_text(statement, 8) != nil ? String(cString: sqlite3_column_text(statement, 8)) : nil,
                    status: sqlite3_column_text(statement, 9) != nil ? String(cString: sqlite3_column_text(statement, 9)) : nil
                )
                catDetails.append(catDetail)
            }
        }
        sqlite3_finalize(statement)
        return catDetails
    }
    
    func updateCatDetails(id: Int, shipmentId: String?, shipmentName: String?, shipmentDescription: String?,
                        mobility: String?, userAccessGroup: String?, status: String?) -> Bool {
        let updateStatement = """
            UPDATE CatDetails SET ShipmentID = ?, ShipmentName = ?, ShipmentDescription = ?,
                                Mobility = ?, UserAccessGroup = ?, Status = ?
            WHERE id = ?
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, updateStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (shipmentId as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (shipmentName as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (shipmentDescription as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (mobility as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (userAccessGroup as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, (status as NSString?)?.utf8String, -1, nil)
            sqlite3_bind_int(statement, 7, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func deleteCatDetails(id: Int) -> Bool {
        let deleteStatement = "DELETE FROM CatDetails WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(database, deleteStatement, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                sqlite3_finalize(statement)
                return true
            }
        }
        sqlite3_finalize(statement)
        return false
    }
    
    func deleteSubCategoryWithDetails(subCatId: String) -> Bool {
        var success = false
        
        // Start a transaction
        if sqlite3_exec(database, "BEGIN TRANSACTION", nil, nil, nil) == SQLITE_OK {
            
            // 1. Delete all details for this subcategory
            let deleteDetailsStatement = "DELETE FROM CatDetails WHERE subCat_id = ?"
            var detailStmt: OpaquePointer?
            
            if sqlite3_prepare_v2(database, deleteDetailsStatement, -1, &detailStmt, nil) == SQLITE_OK {
                sqlite3_bind_text(detailStmt, 1, (subCatId as NSString).utf8String, -1, nil)
                if sqlite3_step(detailStmt) == SQLITE_DONE {
                    success = true
                }
            }
            sqlite3_finalize(detailStmt)
            
            // 2. Delete the subcategory itself (only if details delete worked)
            if success {
                let deleteSubCatStatement = "DELETE FROM SubCategory WHERE subCat_id = ?"
                var subCatStmt: OpaquePointer?
                
                if sqlite3_prepare_v2(database, deleteSubCatStatement, -1, &subCatStmt, nil) == SQLITE_OK {
                    sqlite3_bind_text(subCatStmt, 1, (subCatId as NSString).utf8String, -1, nil)
                    if sqlite3_step(subCatStmt) == SQLITE_DONE {
                        success = true
                    } else {
                        success = false
                    }
                }
                sqlite3_finalize(subCatStmt)
            }
            
            // Commit or rollback transaction
            if success {
                sqlite3_exec(database, "COMMIT", nil, nil, nil)
            } else {
                sqlite3_exec(database, "ROLLBACK", nil, nil, nil)
            }
        }
        
        return success
    }
    
    // MARK: - Utility Methods
    func closeDatabase() {
        sqlite3_close(database)
    }
    
    deinit {
        closeDatabase()
    }
}

// MARK: - Data Models
struct CatDetailRecord {
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
