//
//  CategoryListVC.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit
import Combine

class CategoryListVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblCategory: UITableView!
    
    // MARK: - Properties
    private let viewModel = CategoryViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator : UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCategories()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "Categories"
        lblTitle.text = "Category List"
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
        // Setup activity indicator
        
        // Setup header view
        headerView.layer.cornerRadius = 12
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        headerView.layer.shadowRadius = 4
        headerView.layer.shadowOpacity = 0.1
        
        let nib = UINib(nibName: "CategoryListCell", bundle: nil)
        self.tblCategory.register(nib, forCellReuseIdentifier: "CategoryListCell")
                
    }
    
    private func setupBindings() {
        // Bind categories
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.tblCategory.reloadData()
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
                    print("derror")
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        tblCategory.delegate = self
        tblCategory.dataSource = self
        tblCategory.separatorStyle = .none
        tblCategory.backgroundColor = .systemGroupedBackground
    }
    
    private func updateHeaderInfo() {
        lblTitle.text = "Category List"
    }
    
    
    // MARK: - Navigation
    private func navigateToSubCategories(for category: CategoryModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let subCategoryVC = storyboard.instantiateViewController(withIdentifier: "SubCategoryVC") as? SubCategoryVC {
            subCategoryVC.selectedCategory = category
            navigationController?.pushViewController(subCategoryVC, animated: true)
        }
    }

}

// MARK: - UITableViewDataSource
extension CategoryListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell") as! CategoryListCell
        
        let category = viewModel.categories[indexPath.row]
        cell.configure(obj: category)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CategoryListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = viewModel.categories[indexPath.row]
        navigateToSubCategories(for: category)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
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
    
}
