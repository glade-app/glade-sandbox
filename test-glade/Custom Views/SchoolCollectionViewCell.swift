//
//  SchoolCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit


class SchoolCollectionViewCell: UICollectionViewCell {

    class var reuseIdentifier: String {
        return "SchoolCollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "SchoolCollectionViewCell"
    }
    
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 20
    }
    
    func configureCell(schoolName: String, image: UIImage) {
        schoolLabel.text = schoolName
        imageView.image = image

    }

}
