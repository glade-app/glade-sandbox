//
//  SocialCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/22/20.
//

import UIKit
import FontAwesome_swift

class SocialCollectionViewCell: UICollectionViewCell {
    let socials = [
        "facebook": UIImage.fontAwesomeIcon(name: .facebook, style: .brands, textColor: UIColor.black, size: CGSize(width: 40, height: 40)),
        "instagram": UIImage.fontAwesomeIcon(name: .instagram, style: .brands, textColor: UIColor.black, size: CGSize(width: 40, height: 40)),
        "snapchat": UIImage.fontAwesomeIcon(name: .snapchat, style: .brands, textColor: UIColor.black, size: CGSize(width: 40, height: 40)),
    ]
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var socialImageContainer: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var socialImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var tagLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {      
        self.socialImage.layer.cornerRadius = self.socialImage.frame.width / 2
        
        self.socialImageContainer.layer.cornerRadius = self.socialImageContainer.frame.width / 2

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.socialImageContainer)
        self.socialImageContainer.addSubview(self.socialImage)
        self.container.addSubview(self.tagLabel)
            
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.socialImageContainer.topAnchor.constraint(equalTo: self.container.topAnchor),
            self.socialImageContainer.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 5),
            self.socialImageContainer.heightAnchor.constraint(equalToConstant: 40),
            self.socialImageContainer.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            self.socialImage.topAnchor.constraint(equalTo: self.socialImageContainer.topAnchor),
            self.socialImage.leftAnchor.constraint(equalTo: self.socialImageContainer.leftAnchor),
            self.socialImage.bottomAnchor.constraint(equalTo: self.socialImageContainer.bottomAnchor),
            self.socialImage.rightAnchor.constraint(equalTo: self.socialImageContainer.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.tagLabel.centerYAnchor.constraint(equalTo: self.socialImageContainer.centerYAnchor),
            self.tagLabel.leftAnchor.constraint(equalTo: self.socialImageContainer.rightAnchor, constant: 10),
            self.tagLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(social: Social) {
        socialImage.image = socials[social.name!]
        tagLabel.text = social.tag!
    }
}

