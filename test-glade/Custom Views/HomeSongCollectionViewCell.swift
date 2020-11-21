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
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var songImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var songName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.text = "Song"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songDescription: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.white
        label.textAlignment = .left
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
            self.songImageView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.songImageView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
            self.songImageView.heightAnchor.constraint(equalTo: self.container.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.songName.topAnchor.constraint(equalTo: self.songImageView.bottomAnchor, constant: 5),
            self.songName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.songName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            self.songDescription.topAnchor.constraint(equalTo: self.songName.bottomAnchor, constant: 0),
            self.songDescription.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
            self.songDescription.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Song) {
        let songImageUrl = URL(string: data.album!.images![1].url!)
        self.songImageView.kf.setImage(with: songImageUrl)
        self.songName.text = data.name!
        self.songImageView.layer.cornerRadius = self.songImageView.frame.height / 2

        var description = ""
        for i in 0...data.artists!.count - 1 {
            description += "\(data.artists![i].name!)"
            if i != data.artists!.count - 1 {
                description += ", "
            }
        }
        self.songDescription.text = description
    }
}
