//
//  HomeArtistCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

import UIKit
import Kingfisher

class ArtistCollectionViewCell: UICollectionViewCell {
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
    
    var artistImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var artistName: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.text = "Song"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.artistImageView.layer.cornerRadius = self.artistImageView.frame.width / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.container)
        self.container.addSubview(self.body)
        self.body.addSubview(self.artistImageView)
        self.body.addSubview(self.artistName)
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
            self.artistImageView.topAnchor.constraint(equalTo: self.body.topAnchor),
            self.artistImageView.bottomAnchor.constraint(equalTo: self.body.bottomAnchor),
            self.artistImageView.leftAnchor.constraint(equalTo: self.body.leftAnchor, constant: 10),
            self.artistImageView.widthAnchor.constraint(equalTo: self.artistImageView.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.artistName.centerYAnchor.constraint(equalTo: self.artistImageView.centerYAnchor),
            self.artistName.leftAnchor.constraint(equalTo: self.artistImageView.rightAnchor, constant: 15),
            self.artistName.rightAnchor.constraint(equalTo: self.body.rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            self.indexLabel.rightAnchor.constraint(equalTo: self.artistImageView.leftAnchor, constant: -20),
            self.indexLabel.topAnchor.constraint(equalTo: self.artistImageView.topAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Artist, index: Int) {
        let artistImageUrl = URL(string: data.images![1].url!)
        self.artistImageView.kf.setImage(with: artistImageUrl)
        self.artistName.text = data.name!
        self.indexLabel.text = "\(index + 1)."
    }
}

//class HomeArtistCollectionViewCell: UICollectionViewCell {
//    var container: UIView = {
//        let view = UIView()
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    var artistImageView: UIImageView = {
//        let imageView: UIImageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.masksToBounds = true
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    var artistName: UILabel = {
//        let label: UILabel = UILabel()
//        label.numberOfLines = 1
//        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        label.textAlignment = .left
//        label.text = "Artist"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.artistImageView.layer.cornerRadius = self.artistImageView.frame.height / 2
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.contentView.addSubview(self.container)
//        self.container.addSubview(self.artistImageView)
//        self.container.addSubview(self.artistName)
//        
//        NSLayoutConstraint.activate([
//            self.container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            self.container.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
//            self.container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
//            self.container.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
//        ])
//        
//        NSLayoutConstraint.activate([
//            self.artistImageView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 0),
//            self.artistImageView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
//            self.artistImageView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
//            self.artistImageView.heightAnchor.constraint(equalTo: self.container.widthAnchor, constant: 0),
//        ])
//        
//        NSLayoutConstraint.activate([
//            self.artistName.topAnchor.constraint(equalTo: self.artistImageView.bottomAnchor, constant: 5),
//            self.artistName.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 0),
//            self.artistName.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: 0),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(data: Artist) {
//        let artistImageUrl = URL(string: data.images![1].url!)
//        self.artistImageView.kf.setImage(with: artistImageUrl)
//        self.artistName.text = data.name!
//    }
//}
