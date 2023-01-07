//  DiscoverCell.swift
//  ArkitFaceStoryFilterSwift
//  Created by Kenan Baylan on 27.12.2022.



import UIKit

class DiscoverCell: UITableViewCell {
    
  
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = 20.0
        contentView.backgroundColor = .systemGray
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
