//
//  HomeSongCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit

class HomeSongCollectionViewCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var songImageView: UIView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(named: "berkeley2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var songName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.text = "Song"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songDescription: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.songImageView)
        self.container.addSubview(self.songName)
        self.container.addSubview(self.songDescription)
        
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.songImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0),
            self.songImageView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: 0),
            self.songImageView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.songImageView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            self.songName.bottomAnchor.constraint(equalTo: self.songDescription.topAnchor, constant: -5),
            self.songName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20),
            self.songName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            self.songDescription.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10),
            self.songDescription.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
            self.songDescription.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
