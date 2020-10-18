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
    class var reuseIdentifier: String {
        return "HorizontalCollectionViewCellReuseIdentifier"
    }
    
    class var nibName: String {
        return "HorizontalCollectionViewCell"
    }
    
    func configureHorizontal(subjectName: String, image: UIImage) {
        imageView.image = image
        nameLabel.text = subjectName
        
        imageView.contentMode = .scaleAspectFill
        nameLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        nameLabel.textColor = UIColor.white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
