//
//  HorizontalCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 10/18/20.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    class var reuseIdentifier: String {
        return "HorizontalCollectionViewCellReuseIdentifier"
    }
    
    class var nibName: String {
        return "HorizontalCollectionViewCell"
    }
    
    func configure(name: String, description: String, image: UIImage) {
        imageView.image = image
        nameLabel.text = name
        descriptionLabel.text = description
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.numberOfLines = 0
    }
    
    override func awakeFromNib() {
        print("here in hviewcell")
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
