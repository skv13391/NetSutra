import UIKit

class DetailListCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shipmentNameLabel: UILabel!
    @IBOutlet weak var shipmentIdLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mobilityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userAccessGroupLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Setup Methods
    private func setupCell() {
        // Setup container view
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        // Setup labels
        shipmentNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        shipmentNameLabel.textColor = .label
        
        shipmentIdLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        shipmentIdLabel.textColor = .secondaryLabel
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 2
        
        mobilityLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        mobilityLabel.textColor = .systemBlue
        
        statusLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        statusLabel.textColor = .systemGreen
        
        userAccessGroupLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        userAccessGroupLabel.textColor = .systemOrange
        
        // Setup selection style
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Configuration
    func configure(obj: DetailModel) {
        shipmentNameLabel.text = obj.displayName
        shipmentIdLabel.text = "ID: \(obj.formattedShipmentId)"
        descriptionLabel.text = obj.shortDescription
        mobilityLabel.text = obj.mobilityDisplay
        statusLabel.text = obj.statusDisplay
        userAccessGroupLabel.text = obj.userAccessGroupDisplay
        
        // Update colors based on status
        updateStatusColor(obj.isActive)
        
        // Update colors based on mobility
        updateMobilityColor(obj)
    }
    
    private func updateStatusColor(_ isActive: Bool) {
        if isActive {
            statusLabel.textColor = .systemGreen
        } else {
            statusLabel.textColor = .systemRed
        }
    }
    
    private func updateMobilityColor(_ detail: DetailModel) {
        if detail.isMobile {
            mobilityLabel.textColor = .systemBlue
        } else if detail.isPortable {
            mobilityLabel.textColor = .systemOrange
        } else if detail.isStationary {
            mobilityLabel.textColor = .systemGray
        } else {
            mobilityLabel.textColor = .systemPurple
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        shipmentNameLabel.text = nil
        shipmentIdLabel.text = nil
        descriptionLabel.text = nil
        mobilityLabel.text = nil
        statusLabel.text = nil
        userAccessGroupLabel.text = nil
    }
}
