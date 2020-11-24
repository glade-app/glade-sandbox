//
//  UserCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/23/20.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var userImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var userName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = "User Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.container)
        self.container.addSubview(self.userImageView)
        self.container.addSubview(self.userName)

        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            self.userImageView.widthAnchor.constraint(equalToConstant: 50),
            self.userImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 10),
            self.userImageView.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
        ])
        let imageHeightConstraint = self.userImageView.heightAnchor.constraint(equalToConstant: 50)
        imageHeightConstraint.priority = UILayoutPriority(999)
        imageHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            self.userName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.userName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
            self.userName.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -20)
        ])
        let userNameTopConstraint = self.userName.topAnchor.constraint(equalTo: self.userImageView.bottomAnchor, constant: 10)
        userNameTopConstraint.priority = UILayoutPriority(999)
        userNameTopConstraint.isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(data: User) {
        let userImageUrl = URL(string: data.images![0].url!)
        self.userImageView.kf.setImage(with: userImageUrl)
        self.userName.text = data.displayName!
    }
}
