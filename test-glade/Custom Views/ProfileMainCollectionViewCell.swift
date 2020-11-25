//
//  ProfileUserCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/21/20.
//

import UIKit

class ProfileMainCollectionViewCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        //view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profilePictureContainer: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var profilePicture: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.width / 2
        
        self.profilePictureContainer.layer.cornerRadius = self.profilePictureContainer.frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.profilePictureContainer)
        self.profilePictureContainer.addSubview(self.profilePicture)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.descriptionLabel)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.profilePictureContainer.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 40),
            self.profilePictureContainer.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.profilePictureContainer.widthAnchor.constraint(equalToConstant: 120),
        ])
        let imageHeightConstraint = self.profilePictureContainer.heightAnchor.constraint(equalToConstant: 120)
        imageHeightConstraint.priority = UILayoutPriority(999)
        imageHeightConstraint.isActive = true

        
        NSLayoutConstraint.activate([
            self.profilePicture.topAnchor.constraint(equalTo: self.profilePictureContainer.topAnchor),
            self.profilePicture.leftAnchor.constraint(equalTo: self.profilePictureContainer.leftAnchor),
            self.profilePicture.bottomAnchor.constraint(equalTo: self.profilePictureContainer.bottomAnchor),
            self.profilePicture.rightAnchor.constraint(equalTo: self.profilePictureContainer.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.nameLabel.centerYAnchor.constraint(equalTo: self.profilePictureContainer.centerYAnchor),
            self.nameLabel.leftAnchor.constraint(equalTo: self.profilePictureContainer.rightAnchor, constant: 20),
            self.nameLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.profilePictureContainer.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10),
        ])
        let descriptionTopConstraint = self.descriptionLabel.topAnchor.constraint(equalTo: self.profilePictureContainer.bottomAnchor, constant: 10)
        descriptionTopConstraint.priority = UILayoutPriority(999)
        descriptionTopConstraint.isActive = true


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: User) {        
        let profilePictureUrl = data.images?[0].url ?? ""
        if profilePictureUrl != "" {
            let profilePictureUrlObj = URL(string: profilePictureUrl)
            profilePicture.kf.setImage(with: profilePictureUrlObj)
        }
        nameLabel.text = data.displayName
        descriptionLabel.text = data.description
    }
}
