import UIKit
import Combine

class DetailVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    
    // MARK: - Properties
    private let viewModel = DetailViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView!
    var selectedSubCategory: SubCategoryModel?
    var selectedCategory: CategoryModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        loadDetails()
    }
    
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "Details"
        
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
        
        
        
    }
    
    private func setupBindings() {
        // Bind details
        viewModel.$details
            .receive(on: DispatchQueue.main)
            .sink { [weak self] details in
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
    
    
    
    private func loadDetails() {
        guard let subCategory = selectedSubCategory,
              let category = selectedCategory else {
            showAlert(title: "Error", message: "No subcategory selected")
            return
        }
        
        lblTitle.text = "\(subCategory.subCatName) "
        viewModel.loadDetail(for: subCategory.subCatId, categoryId: category.catId) { [weak self] detail in
                    guard let self = self else { return }
                    
                    if let detail = detail {
                           
                        // Update UI
                        DispatchQueue.main.async {
                            self.title = detail.shipmentName
                            self.showDetails(detail: detail)
                            // self.myLabel.text = detail.shipmentDescription
                        }
                    } else {
                        // ❌ No detail found
                        print("No detail found for this subCategory and category")
                    }
                }
        
        
    }
    
    private func updateHeaderInfo() {
        if let subCategory = selectedSubCategory {
            let stats = viewModel.statistics
            lblTitle.text = "\(subCategory.subCatName) Details (\(stats.total))"
        }
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showDetailInfo(for detail: DetailModel) {
        self.showDetails(detail: detail)
    }
    
    func showDetails(detail: DetailModel) {
        let regularFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        let semiboldFont = UIFont.systemFont(ofSize: 18, weight: .semibold)

        
        let attrs1 = [NSAttributedString.Key.font : semiboldFont, NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attrs2 = [NSAttributedString.Key.font : regularFont, NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        
        
        let attributedString1 = NSMutableAttributedString(string:"Shipment-ID : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString2 = NSMutableAttributedString(string:"\(detail.shipmentId ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        let attributedString3 = NSMutableAttributedString(string:"\n" + "Shipment-Name : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString4 = NSMutableAttributedString(string:"\(detail.shipmentName ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        
        let attributedString5 = NSMutableAttributedString(string:"\n" + "Description : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString6 = NSMutableAttributedString(string:"\(detail.shipmentDescription ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        let attributedString7 = NSMutableAttributedString(string: "\n" + "Mobility : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString8 = NSMutableAttributedString(string:"\(detail.mobility ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        let attributedString9 = NSMutableAttributedString(string: "\n" + "User Access Group : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString10 = NSMutableAttributedString(string:"\(detail.userAccessGroup ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        
        let attributedString11 = NSMutableAttributedString(string: "\n" + "Status : " , attributes:attrs1 as [NSAttributedString.Key : Any])
        
        let attributedString12 = NSMutableAttributedString(string:"\(detail.status ?? "" )", attributes:attrs2 as [NSAttributedString.Key : Any])
        
        
        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)
        attributedString1.append(attributedString5)
        attributedString1.append(attributedString6)
        attributedString1.append(attributedString7)
        attributedString1.append(attributedString8)
        attributedString1.append(attributedString9)
        attributedString1.append(attributedString10)
        attributedString1.append(attributedString11)
        attributedString1.append(attributedString12)
        
        self.lblDetails.attributedText = attributedString1
        
    }
    
}
