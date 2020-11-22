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
        view.clipsToBounds = true
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "berkeley_home")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = "School"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var usernameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = "Members"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var membersValue: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = "123"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.profilePictureContainer)
        self.profilePictureContainer.addSubview(self.profilePicture)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.usernameLabel)
            
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.profilePictureContainer.centerYAnchor.constraint(equalTo: self.container.centerYAnchor),
            self.profilePictureContainer.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.profilePictureContainer.heightAnchor.constraint(equalToConstant: 150),
            self.profilePictureContainer.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        NSLayoutConstraint.activate([
            self.profilePicture.topAnchor.constraint(equalTo: self.profilePictureContainer.topAnchor),
            self.profilePicture.leftAnchor.constraint(equalTo: self.profilePictureContainer.leftAnchor, constant: 25),
            self.profilePicture.bottomAnchor.constraint(equalTo: self.profilePictureContainer.bottomAnchor),
            self.profilePicture.rightAnchor.constraint(equalTo: self.profilePictureContainer.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20),
            self.nameLabel.leftAnchor.constraint(equalTo: self.profilePictureContainer.rightAnchor, constant: 10),
            self.nameLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20),
        ])
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
        usernameLabel.text = data.id
        
//            if user.socials?["facebook"] != nil || user.socials?["instagram"] != nil || user.socials?["snapchat"] != nil {
//                let socialsLabel = UILabel()
//                socialsLabel.text = "Socials"
//                socialsLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//            }
//
//            if user.socials?["facebook"] != nil {
//                let facebookLabel = UILabel()
//                facebookLabel.text = user.socials?["facebook"]
//            }
//
//            if user.socials?["instagram"] != nil {
//                let instagramLabel = UILabel()
//                instagramLabel.text = user.socials?["instagram"]
//            }
//
//            if user.socials?["snapchat"] != nil {
//                let snapchatLabel = UILabel()
//                snapchatLabel.text = user.socials?["snapchat"]
//            }
//        }
    }
}
