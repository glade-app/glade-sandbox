//
//  HomeHeader.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

class HomeSectionHeader: UICollectionReusableView {
    
    var headerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(self.headerLabel)

        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0),
            self.headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0),
        ])
        let headerBottomConstraint = self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        headerBottomConstraint.priority = UILayoutPriority(999)
        headerBottomConstraint.isActive = true
    }
    
    func configure(text: String) {
        headerLabel.text = text
    }
}
