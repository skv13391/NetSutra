//
//  CategoryListCell.swift
//  NetSutra
//
//  Created by Sunil on 31/08/25.
//

import UIKit

class CategoryListCell: UITableViewCell {
    @IBOutlet weak var imgList: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        setupLabel()
    }
    
    // MARK: - Setup Methods
    private func setupImageView() {
        // Add corner radius
        imgList.layer.cornerRadius = 10
        imgList.clipsToBounds = true
    
        // Additional styling
        imgList.contentMode = .scaleAspectFill
        imgList.backgroundColor = .systemGray6
    }
    
    private func setupLabel() {
        lblName.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        lblName.textColor = .white
        lblName.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(obj : CategoryModel) {
        if obj.categoryName == "Electronics" {
            self.imgList.image = UIImage(named: "electronic")
        } else if obj.categoryName == "Clothing" {
            self.imgList.image = UIImage(named: "clothes")
        }
        else if obj.categoryName == "Food" {
            self.imgList.image = UIImage(named: "food")
        }
        else if obj.categoryName == "Automotive" {
            self.imgList.image = UIImage(named: "automtive")
        }
        else if obj.categoryName == "Places" {
            self.imgList.image = UIImage(named: "place")
        }else {
            self.imgList.image = UIImage(named: "homeDecore")
        }
        
        self.lblName.text = obj.categoryName
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        imgList.image = nil
        lblName.text = nil
    }
}
