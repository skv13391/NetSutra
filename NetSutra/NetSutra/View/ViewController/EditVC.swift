//
//  EditVC.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit

class EditVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFeildShipemntId: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var txtFieldShipmenttName: UITextField!
    @IBOutlet weak var txtFieldUserAcess: UITextField!
    @IBOutlet weak var txtfeildDesciption: UITextView!
    @IBOutlet weak var txtFieldMobility: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var swithActio: UISwitch!
    @IBOutlet weak var scrlHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func tapBack(_ sender: Any) {
    }
    
    @IBAction func tapSubmit(_ sender: Any) {
    }
    
    @IBAction func tapAction(_ sender: Any) {
    }
}
