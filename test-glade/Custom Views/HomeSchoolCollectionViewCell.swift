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
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        view.layer.shadowRadius = 1.0
        view.layer.shadowOpacity = 0.3
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var schoolImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "berkeley_home")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.schoolImageView)
        self.container.addSubview(self.schoolName)
        self.container.addSubview(self.membersLabel)
        self.container.addSubview(self.membersValue)
        
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Dictionary<String, Any>) {
        let school = UserDefaults.standard.string(forKey: "school")
        self.schoolName.text = school!
        self.membersValue.text = "\(data["userCount"]!)"
    }
}
