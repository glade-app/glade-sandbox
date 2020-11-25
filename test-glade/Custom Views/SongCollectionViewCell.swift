//
//  HomeSongCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit
import Kingfisher

class SongCollectionViewCell: UICollectionViewCell {
    var container: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var body: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var indexLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Index"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var songName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.text = "Song"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songDescription: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.songImageView.layer.cornerRadius = 4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.body)
        self.body.addSubview(self.songImageView)
        self.body.addSubview(self.songName)
        self.body.addSubview(self.songDescription)
        self.container.addSubview(self.indexLabel)
            
        NSLayoutConstraint.activate([
            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.body.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 20),
            self.body.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 40),
            self.body.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10),
            self.body.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            self.songImageView.topAnchor.constraint(equalTo: self.body.topAnchor),
            self.songImageView.bottomAnchor.constraint(equalTo: self.body.bottomAnchor),
            self.songImageView.leftAnchor.constraint(equalTo: self.body.leftAnchor, constant: 10),
            self.songImageView.widthAnchor.constraint(equalTo: self.songImageView.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.songName.bottomAnchor.constraint(equalTo: self.songImageView.centerYAnchor, constant: 2.5),
            self.songName.leftAnchor.constraint(equalTo: self.songImageView.rightAnchor, constant: 15),
            self.songName.rightAnchor.constraint(equalTo: self.body.rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.songDescription.topAnchor.constraint(equalTo: self.songName.bottomAnchor),
            self.songDescription.leftAnchor.constraint(equalTo: self.songName.leftAnchor),
            self.songDescription.rightAnchor.constraint(equalTo: self.body.rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.indexLabel.rightAnchor.constraint(equalTo: self.songImageView.leftAnchor, constant: -20),
            self.indexLabel.topAnchor.constraint(equalTo: self.songImageView.topAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Song, index: Int) {
        let songImageUrl = URL(string: data.album!.images![1].url!)
        self.songImageView.kf.setImage(with: songImageUrl)
        self.indexLabel.text = "\(index + 1)."
        self.songName.text = data.name!

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

//
//class HomeSongCollectionViewCell: UICollectionViewCell {
//    var container: UIView = {
//        let view = UIView()
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    var indexLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
//        label.textColor = UIColor.white
//        label.textAlignment = .left
//        label.text = "Index"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var songImageView: UIImageView = {
//        let imageView: UIImageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    var songName: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        label.textColor = UIColor.white
//        label.textAlignment = .left
//        label.text = "Song"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var songDescription: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        label.textColor = UIColor.white
//        label.textAlignment = .left
//        label.text = "Description"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.songImageView.layer.cornerRadius = 20
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.contentView.addSubview(self.container)
//        self.container.addSubview(self.songImageView)
//        self.container.addSubview(self.indexLabel)
//        self.container.addSubview(self.songName)
//        self.container.addSubview(self.songDescription)
//
//        NSLayoutConstraint.activate([
//            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
//            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            self.indexLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
//            self.indexLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
//        ])
//
//        NSLayoutConstraint.activate([
//            self.songImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 10),
//            self.songImageView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -10),
//            self.songImageView.heightAnchor.constraint(equalToConstant: 150),
//            self.songImageView.widthAnchor.constraint(equalToConstant: 150),
//        ])
//
//        NSLayoutConstraint.activate([
//            self.songName.topAnchor.constraint(equalTo: self.songImageView.bottomAnchor, constant: 5),
//            self.songName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
//            self.songName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 10),
//        ])
//
//        NSLayoutConstraint.activate([
//            self.songDescription.topAnchor.constraint(equalTo: self.songName.bottomAnchor, constant: 0),
//            self.songDescription.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 10),
//            self.songDescription.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 10),
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(data: Song, index: Int) {
//        let songImageUrl = URL(string: data.album!.images![1].url!)
//        self.songImageView.kf.setImage(with: songImageUrl)
//        self.indexLabel.text = "\(index + 1)"
//        self.songName.text = data.name!
//
//        var description = ""
//        for i in 0...data.artists!.count - 1 {
//            description += "\(data.artists![i].name!)"
//            if i != data.artists!.count - 1 {
//                description += ", "
//            }
//        }
//        self.songDescription.text = description
//    }
//}
