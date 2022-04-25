//
//  DeviceTableViewCell.swift
//  MDMwithMVVM
//
//  Created by Tibin Thomas on 24/04/22.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subtitleText: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    var item: Device! {
        didSet {
            setDeviceData()
        }
    }

    private func setDeviceData() {
        titleText.text = item.title
        subtitleText.text = item.type
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius = 6.0
        containerView.layer.shadowOpacity = 0.7
    }
    
}
