import Foundation

// MARK: - Detail Model
struct DetailModel {
    let shipmentId: String?
    let shipmentName: String?
    let shipmentDescription: String?
    let mobility: String?
    let userAccessGroup: String?
    let status: String?
    
    init(shipmentId: String?, shipmentName: String?, shipmentDescription: String?, mobility: String?, userAccessGroup: String?, status: String?) {
        self.shipmentId = shipmentId
        self.shipmentName = shipmentName
        self.shipmentDescription = shipmentDescription
        self.mobility = mobility
        self.userAccessGroup = userAccessGroup
        self.status = status
    }
}

// MARK: - Detail Model Extensions
extension DetailModel {
    
    /// Display name for the detail
    var displayName: String {
        return shipmentName ?? "No Name"
    }
    
    /// Formatted status with color indication
    var statusDisplay: String {
        return status ?? "Unknown"
    }
    
    /// Formatted mobility type
    var mobilityDisplay: String {
        return mobility ?? "Not Specified"
    }
    
    /// Formatted user access group
    var userAccessGroupDisplay: String {
        return userAccessGroup ?? "General"
    }
    
    /// Check if detail is active
    var isActive: Bool {
        return status?.lowercased() == "active"
    }
    
    /// Check if detail is mobile
    var isMobile: Bool {
        return mobility?.lowercased() == "mobile"
    }
    
    /// Check if detail is portable
    var isPortable: Bool {
        return mobility?.lowercased() == "portable"
    }
    
    /// Check if detail is stationary
    var isStationary: Bool {
        return mobility?.lowercased() == "stationary"
    }
    
    /// Short description (truncated if too long)
    var shortDescription: String {
        guard let description = shipmentDescription else { return "No description available" }
        
        if description.count > 100 {
            return String(description.prefix(100)) + "..."
        }
        return description
    }
    
    /// Formatted shipment ID
    var formattedShipmentId: String {
        return shipmentId ?? "N/A"
    }
}
