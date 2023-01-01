//
//  FilterCollectionViewCell.swift
//  ArkitFaceStoryFilterSwift
//
//  Created by Hakan Tekir on 1.01.2023.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "FilterCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FilterCollectionViewCell", bundle: nil)
    }
}
