//
//  EditVC.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit
import Combine

class EditVC: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var lblOuterSelect: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFeildShipemntId: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var desHeight: NSLayoutConstraint!
    @IBOutlet weak var txtFieldShipmenttName: UITextField!
    @IBOutlet weak var txtFieldUserAcess: UITextField!
    @IBOutlet weak var txtfeildDesciption: UITextView!
    @IBOutlet weak var txtFieldMobility: UITextField!
    @IBOutlet weak var swithActio: UISwitch!
    @IBOutlet weak var btnSUp: UIButton!
    @IBOutlet weak var scrlHeight: NSLayoutConstraint!
    var selectedSubCategory: SubCategoryModel?
    var selectedCategory: CategoryModel?
    private var cancellables = Set<AnyCancellable>()
    private var activityIndicator: UIActivityIndicatorView!
    private let viewModel = DetailViewModel()
    var selectMobility = NSMutableArray()
    var userAceess = NSMutableArray()

    var selectType = "Mobility"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUPUI()
        self.loadDetails()
        self.addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }
    
    func setUPUI()
    {
        
        self.btnCancel.layer.cornerRadius = 10
        self.btnCancel.clipsToBounds = true
        self.btnCancel.layer.borderWidth = 1
        self.btnCancel.layer.borderColor = UIColor.black.cgColor
        self.btnCancel.setTitle("Cancel", for: .normal)
        self.btnCancel.setTitleColor(.black, for: .normal)
        
        self.btnSUp.layer.cornerRadius = 10
        self.btnSUp.clipsToBounds = true
        self.btnSUp.layer.borderWidth = 1
        self.btnSUp.layer.borderColor = UIColor.black.cgColor
        self.btnSUp.setTitle("Update", for: .normal)
        self.btnSUp.setTitleColor(.white, for: .normal)
        self.btnSUp.backgroundColor = .systemBlue
        
        
        self.btnSubmit.layer.cornerRadius = 10
        self.btnSubmit.clipsToBounds = true
        self.txtFeildShipemntId.delegate = self
        self.txtFieldShipmenttName.delegate = self
        self.txtFieldUserAcess.delegate = self
        self.txtFieldMobility.delegate = self
        self.txtfeildDesciption.delegate = self
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.separatorStyle = .none
        self.tblView.backgroundColor = .systemGroupedBackground
        let nib = UINib(nibName: "selectMobilityCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "selectMobilityCell")
        
        
        var dict = ["name" : "Fixed", "status" : "false"]
        self.selectMobility.add(dict)
        
        dict = ["name" : "Mobility", "status" : "false"]
        self.selectMobility.add(dict)
        
        dict = ["name" : "Both", "status" : "false"]
        self.selectMobility.add(dict)
        
        var dictUser = ["name" : "Shopkeeper", "status" : "false"]
        self.userAceess.add(dictUser)
        
        dictUser = ["name" : "Distributer", "status" : "false"]
        self.userAceess.add(dictUser)
        
        dictUser = ["name" : "Holesaler", "status" : "false"]
        self.userAceess.add(dictUser)
        
        dictUser = ["name" : "Owner", "status" : "false"]
        self.userAceess.add(dictUser)
        
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
        self.txtFeildShipemntId.inputAccessoryView = toolbar
        }
        
        @objc func doneButtonTapped() {
            self.txtfeildDesciption.resignFirstResponder() // Dismiss keyboard
            self.txtFeildShipemntId.resignFirstResponder()
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
    
   
    @IBAction func btnCancel(_ sender: Any) {
        self.outerView.isHidden = true
    }
    
    
    @IBAction func btnUpdateVI(_ sender: Any) {
        self.outerView.isHidden = true
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
            self.outerView.isHidden = false
            self.selectType = "Mobility"
            self.lblOuterSelect.text = "Select Mobility"
            self.tblView.reloadData()
            return false
        }
        if textField == self.txtFieldUserAcess {
            self.outerView.isHidden = false
            self.selectType = "Access"
            self.lblOuterSelect.text = "Select User Access"
            self.tblView.reloadData()
            return false
        }
        return true
    }
    
}

extension EditVC  : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selectType == "Mobility"
        {
            if let data = self.selectMobility[indexPath.row] as? NSDictionary {
                let currentStatus = data["status"] as? String ?? "false"
                let newStatus = (currentStatus == "true") ? "false" : "true"
                
                // Create a new updated dictionary
                let updatedData: NSDictionary = [
                    "name": data["name"] ?? "",
                    "status": newStatus
                ]
                
                // Replace in array
                self.selectMobility[indexPath.row] = updatedData
                
                // Reload that row only
                self.tblView.reloadData()
            }
        }
        else{
            if let data = self.userAceess[indexPath.row] as? NSDictionary {
                let currentStatus = data["status"] as? String ?? "false"
                let newStatus = (currentStatus == "true") ? "false" : "true"
                
                // Create a new updated dictionary
                let updatedData: NSDictionary = [
                    "name": data["name"] ?? "",
                    "status": newStatus
                ]
                
                // Replace in array
                self.userAceess[indexPath.row] = updatedData
                
                // Reload that row only
                self.tblView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectType == "Mobility"
        {
            return self.selectMobility.count
        }
        else{
            return self.userAceess.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.selectType == "Mobility"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectMobilityCell") as! selectMobilityCell
            
            let data = self.selectMobility[indexPath.row] as? NSDictionary
            let name = data?.object(forKey: "name")
            cell.lblName.text = name as? String
            
            let status = data?.object(forKey: "status") as? String
            if status == "true"
            {
                cell.btnSelect.setImage(UIImage(named: "square-check"), for: .normal)
            }
            else{
                cell.btnSelect.setImage(UIImage(named: "square"), for: .normal)
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectMobilityCell") as! selectMobilityCell
            
            let data = self.userAceess[indexPath.row] as? NSDictionary
            let name = data?.object(forKey: "name")
            cell.lblName.text = name as? String
            
            let status = data?.object(forKey: "status") as? String
            if status == "true"
            {
                cell.btnSelect.setImage(UIImage(named: "square-check"), for: .normal)
            }
            else{
                cell.btnSelect.setImage(UIImage(named: "square"), for: .normal)
            }
            return cell
        }
        
        
    }
    
}
