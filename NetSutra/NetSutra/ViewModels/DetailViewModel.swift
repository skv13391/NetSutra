//
//  DetailViewModel.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import Foundation
import Combine

// MARK: - Detail ViewModel
class DetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var details: [DetailModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    private let dbManager = DatabaseManager.shared
    private var currentSubCategoryId: String?
    private var currentCategoryId: String?
    
    // MARK: - Initialization
    init() {
        // Initialize without loading data
    }
    
    // MARK: - Public Methods
    
    func loadDetail(for subCategoryId: String, categoryId: String, completion: @escaping (DetailModel?) -> Void) {
        currentSubCategoryId = subCategoryId
        currentCategoryId = categoryId
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let allDetails = self.dbManager.getAllCatDetails()
            
            let dbDetail = allDetails.first {
                $0.subCatId == subCategoryId && $0.catId == categoryId
            }
            
            let detailModel = dbDetail.map {
                DetailModel(
                    shipmentId: $0.shipmentId,
                    shipmentName: $0.shipmentName,
                    shipmentDescription: $0.shipmentDescription,
                    mobility: $0.mobility,
                    userAccessGroup: $0.userAccessGroup,
                    status: $0.status
                )
            }
            
            DispatchQueue.main.async {
                self.details = detailModel.map { [$0] } ?? []
                self.isLoading = false
                completion(detailModel)
            }
        }
    }
    
    /// Refresh details for the current subcategory
    func refreshDetails() {
        guard let subCategoryId = currentSubCategoryId,
              let categoryId = currentCategoryId else { return }
        //loadDetails(for: subCategoryId, categoryId: categoryId)
    }
    
    /// Get total detail count
    var totalDetailCount: Int {
        return details.count
    }
    
    /// Get current subcategory ID
    var getCurrentSubCategoryId: String? {
        return currentSubCategoryId
    }
    
    /// Get current category ID
    var getCurrentCategoryId: String? {
        return currentCategoryId
    }
    
    /// Search details by shipment name
    func searchDetails(byName searchText: String) -> [DetailModel] {
        guard !searchText.isEmpty else { return details }
        
        return details.filter { detail in
            guard let shipmentName = detail.shipmentName else { return false }
            return shipmentName.lowercased().contains(searchText.lowercased())
        }
    }
    
    /// Filter details by status
    func filterDetails(byStatus status: String) -> [DetailModel] {
        return details.filter { detail in
            guard let detailStatus = detail.status else { return false }
            return detailStatus.lowercased() == status.lowercased()
        }
    }
    
    /// Filter details by mobility
    func filterDetails(byMobility mobility: String) -> [DetailModel] {
        return details.filter { detail in
            guard let detailMobility = detail.mobility else { return false }
            return detailMobility.lowercased() == mobility.lowercased()
        }
    }
    
    /// Get unique statuses
    var uniqueStatuses: [String] {
        let statuses = details.compactMap { $0.status }
        return Array(Set(statuses)).sorted()
    }
    
    /// Get unique mobility types
    var uniqueMobilityTypes: [String] {
        let mobilityTypes = details.compactMap { $0.mobility }
        return Array(Set(mobilityTypes)).sorted()
    }
    
    /// Get unique user access groups
    var uniqueUserAccessGroups: [String] {
        let accessGroups = details.compactMap { $0.userAccessGroup }
        return Array(Set(accessGroups)).sorted()
    }
    
    /// Get statistics
    var statistics: (total: Int, active: Int, inactive: Int) {
        let total = details.count
        let active = details.filter { $0.status?.lowercased() == "active" }.count
        let inactive = total - active
        
        return (total: total, active: active, inactive: inactive)
    }
}

