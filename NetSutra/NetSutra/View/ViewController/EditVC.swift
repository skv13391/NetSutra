//
//  EditVC.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit
import Combine

class EditVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFeildShipemntId: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var desHeight: NSLayoutConstraint!
    @IBOutlet weak var txtFieldShipmenttName: UITextField!
    @IBOutlet weak var txtFieldUserAcess: UITextField!
    @IBOutlet weak var txtfeildDesciption: UITextView!
    @IBOutlet weak var txtFieldMobility: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var swithActio: UISwitch!
    @IBOutlet weak var scrlHeight: NSLayoutConstraint!
    var selectedSubCategory: SubCategoryModel?
    var selectedCategory: CategoryModel?
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView!
    private let viewModel = DetailViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPUI()
        self.loadDetails()
        self.addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func setUPUI()
    {
        self.btnSubmit.layer.cornerRadius = 10
        self.btnSubmit.clipsToBounds = true
        self.txtFeildShipemntId.delegate = self
        self.txtFieldShipmenttName.delegate = self
        self.txtFieldUserAcess.delegate = self
        self.txtFieldMobility.delegate = self
        self.txtfeildDesciption.delegate = self
    }
    
    func addDoneButtonOnKeyboard() {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            // Create flexible space & done button
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
            
            toolbar.items = [flexSpace, doneButton]
            
            // Assign toolbar to keyboard
        self.txtfeildDesciption.inputAccessoryView = toolbar
        }
        
        @objc func doneButtonTapped() {
            self.txtfeildDesciption.resignFirstResponder() // Dismiss keyboard
        }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
                            self.setUPDetails(detail: detail)
                            // self.myLabel.text = detail.shipmentDescription
                        }
                    } else {
                        // ❌ No detail found
                        print("No detail found for this subCategory and category")
                    }
                }
        
        
    }
    
    func setUPDetails(detail : DetailModel)
    {
        if let shipmentId = detail.shipmentId {
            self.txtFeildShipemntId.text = shipmentId
        }
        
        if let shipmentName = detail.shipmentName {
            self.txtFieldShipmenttName.text = shipmentName
        }
        
        if let shipmentDes = detail.shipmentDescription {
            self.txtfeildDesciption.text = shipmentDes
        }
        
        if let shipmentMobility = detail.mobility {
            self.txtFieldMobility.text = shipmentMobility
        }
        
        if let userAcesss = detail.userAccessGroup {
            self.txtFieldUserAcess.text = userAcesss
        }
        
        if let status = detail.status {
            if status == "Active" {
                self.swithActio.isOn = true
            }
            else{
                self.swithActio.isOn = false
            }
        }
        
        let regularFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        let screenWidth = UIScreen.main.bounds.width

        let height = detail.shipmentDescription?.height(withConstrainedWidth: (screenWidth - 32), font: regularFont)
        
        self.desHeight.constant = (height! + 20)
    }

    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSubmit(_ sender: Any) {
        
        let db = DatabaseManager.shared
        let success = db.updateCatDetailsBySubCategoryId(
            subCatId: self.selectedSubCategory?.subCatId ?? "0",
            shipmentId: self.txtFeildShipemntId.text ?? "",
            shipmentName: self.txtFieldShipmenttName.text ?? "",
            shipmentDescription: self.txtfeildDesciption.text ?? "",
            mobility: self.txtFieldMobility.text ?? "",
            userAccessGroup: self.txtFieldUserAcess.text ?? "",
            status: self.swithActio.isOn ? "Active" : "Inactive"
        )

        if success {
            print("✅ Details updated successfully")
            self.navigationController?.popViewController(animated: true)
        } else {
            print("❌ Failed to update details")
        }
    }
    
    @IBAction func tapAction(_ sender: UISwitch) {
        if sender.isOn {
            self.swithActio.isOn = true
        }
        else{
            self.swithActio.isOn = false
        }
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )
        
        return ceil(boundingBox.height)
    }
}

extension EditVC : UITextViewDelegate,UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtFieldMobility {
            return false
        }
        if textField == self.txtFieldUserAcess {
            return false
        }
        return true
    }
    
}
