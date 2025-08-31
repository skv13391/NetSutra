//
//  SubCategoryCell.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit

class SubCategoryCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgSub: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(obj : SubCategoryModel)
    {
        imgSub.layer.cornerRadius = 10
        imgSub.clipsToBounds = true
        
        self.lblName.text = obj.subCatName
    }
}
