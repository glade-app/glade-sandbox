//
//  HomeSchoolCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

class HomeSchoolCollectionViewCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var schoolImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "berkeley_school")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var schoolName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = "School"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var membersLabel: UILabel = {
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
    
//    var playsLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
//        label.textColor = UIColor.white
//        label.textAlignment = .left
//        label.text = "Plays"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var playsValue: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        label.textColor = UIColor.white
//        label.textAlignment = .left
//        label.text = "9999"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.schoolImageView)
        self.container.addSubview(self.schoolName)
        self.container.addSubview(self.membersLabel)
        self.container.addSubview(self.membersValue)
//        self.container.addSubview(self.playsLabel)
//        self.container.addSubview(self.playsValue)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.schoolImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0),
            self.schoolImageView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 0),
            self.schoolImageView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.schoolImageView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            self.schoolName.bottomAnchor.constraint(equalTo: self.membersLabel.topAnchor, constant: 0),
            self.schoolName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.schoolName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            self.membersLabel.bottomAnchor.constraint(equalTo: self.membersValue.topAnchor, constant: 0),
            self.membersLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            self.membersValue.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -20),
            self.membersValue.leftAnchor.constraint(equalTo: self.membersLabel.leftAnchor),
        ])
        
//        NSLayoutConstraint.activate([
//            self.playsLabel.bottomAnchor.constraint(equalTo: self.playsValue.topAnchor, constant: 0),
//            self.playsLabel.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20),
//        ])
//
//        NSLayoutConstraint.activate([
//            self.playsValue.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -20),
//            self.playsValue.leftAnchor.constraint(equalTo: self.playsLabel.leftAnchor),
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Dictionary<String, Any>) {
        let school = UserDefaults.standard.string(forKey: "school")
        self.schoolName.text = school!
//        self.schoolImageView.image = image
        self.membersValue.text = "\(data["userCount"]!)"
    }
}
