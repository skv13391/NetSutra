//
//  SubCategoryVC.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit
import Combine

class SubCategoryVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblSubCategory: UITableView!
    
    // MARK: - Properties
    private let viewModel = SubCategoryViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView!
    var selectedCategory: CategoryModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupTableView()
        loadSubCategories()
    }
    
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "Subcategories"
        
        // Setup header view
        headerView.layer.cornerRadius = 12
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowRadius = 4
        headerView.layer.shadowOpacity = 0.1
        
        // Setup activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        
        // Add to view
        view.addSubview(activityIndicator)
        
        // Center it
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Register cell
        let nib = UINib(nibName: "SubCategoryCell", bundle: nil)
        tblSubCategory.register(nib, forCellReuseIdentifier: "SubCategoryCell")
    }
    
    private func setupBindings() {
        // Bind subcategories
        viewModel.$subCategories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] subCategories in
                self?.tblSubCategory.reloadData()
                self?.updateHeaderInfo()
            }
            .store(in: &cancellables)
        
        // Bind loading state
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        // Bind error messages
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.showAlert(title: "Error", message: errorMessage)
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        tblSubCategory.delegate = self
        tblSubCategory.dataSource = self
        tblSubCategory.separatorStyle = .none
        tblSubCategory.backgroundColor = .systemGroupedBackground
    }
    
    private func loadSubCategories() {
        guard let category = selectedCategory else {
            showAlert(title: "Error", message: "No category selected")
            return
        }
        
        lblTitle.text = "\(category.categoryName) Subcategories"
        viewModel.loadSubCategories(for: category.catId)
    }
    
    private func updateHeaderInfo() {
        if let category = selectedCategory {
            lblTitle.text = "\(category.categoryName) Subcategories (\(viewModel.totalSubCategoryCount))"
        }
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showSubCategoryDetails(for subCategory: SubCategoryModel) {
        let alert = UIAlertController(
            title: subCategory.subCatName,
            message: """
                Subcategory ID: \(subCategory.subCatId)
                Subcategory Name: \(subCategory.subCatName)
                """,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "View Details", style: .default) { _ in
            self.navigateToDetails(for: subCategory)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - Navigation
    private func navigateToDetails(for subCategory: SubCategoryModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            detailVC.selectedSubCategory = subCategory
            detailVC.selectedCategory = selectedCategory
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func callDeleteSubCategoryAPI(subCategoryId: String, catID : String) {
        let success = DatabaseManager.shared.deleteSubCategoryWithDetails(subCatId: subCategoryId)
        if success {
            print("Deleted successfully")
            self.setupBindings()
        }
        else{
            // not reload tble
        }
    }
}

// MARK: - UITableViewDataSource
extension SubCategoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryCell") as! SubCategoryCell
        
        let subCategory = viewModel.subCategories[indexPath.row]
        cell.configure(obj: subCategory)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SubCategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let subCategory = viewModel.subCategories[indexPath.row]
        showSubCategoryDetails(for: subCategory)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Header Spacing
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // 10 pixel spacing between cells
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }
    
    // MARK: - Swipe Left Options (Delete & Edit)
        func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            // Delete action
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (_, _, completion) in
                //self.subcategories.remove(at: indexPath.row)
                    // delete row from db
                self.callDeleteSubCategoryAPI(subCategoryId: viewModel.subCategories[indexPath.row].subCatId, catID: selectedCategory!.catId)
                completion(true)
            }
            
            // Edit action
            let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (_, _, completion) in
                let currentName = self.viewModel.subCategories[indexPath.row]
                self.moveToEdit(for: viewModel.subCategories[indexPath.row])
               
                completion(true)
            }
            editAction.backgroundColor = .blue
            
            return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        }
    
    func moveToEdit(for subCategory: SubCategoryModel)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditVC {
            detailVC.selectedSubCategory = subCategory
            detailVC.selectedCategory = selectedCategory
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
