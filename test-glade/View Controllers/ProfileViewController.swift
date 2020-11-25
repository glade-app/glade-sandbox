//
//  ProfileViewController.swift
//  test-glade
//
//  Created by Allen Gu on 11/21/20.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileMainCollectionViewCell.self, forCellWithReuseIdentifier: "profileMain")
        collectionView.register(SocialCollectionViewCell.self, forCellWithReuseIdentifier: "social")
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "artist")
        collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "song")
        collectionView.register(HomeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var user: User?
    var socials: [Social] = []
    var topArtists: [Artist?] = []
    var topSongs: [Song?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadSocials()
        self.loadUserTopArtists()
        self.loadUserTopSongs()
        self.setup()
        self.refreshCollectionView()
    }
    
    func loadSocials() {
        if user!.socials == nil {
            return
        }
        let socialNames = ["facebook", "instagram", "snapchat"]
        for name in socialNames {
            let tag = user!.socials![name]
            if tag != "" {
                self.socials.append(Social(name: name, tag: tag))
            }
        }
    }
    
    func loadUserTopArtists() {
        DataStorage.getUserTopArtists(count: 50, user: user!) { (result, artists) in
            self.topArtists = artists
            DispatchQueue.main.async {
                self.refreshCollectionView()
            }
        }
    }
    
    func loadUserTopSongs() {
        DataStorage.getUserTopSongs(count: 50, user: user!) { (result, songs) in
            self.topSongs = songs
            DispatchQueue.main.async {
                self.refreshCollectionView()
            }
        }
    }
    
    func refreshCollectionView() {
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
    func setup() {
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if section == 0 {
                return LayoutBuilder.buildProfileMainSectionLayout()
            }
            else if section == 1 {
                return LayoutBuilder.buildSocialsSectionLayout()
            }
            else if section == 2 {
                let groupCount: Int = max(self.topArtists.count, 1)
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),  heightDimension: .estimated(90.0*CGFloat(groupCount)))
                return LayoutBuilder.buildArtistsSectionLayout(groupSize: groupSize, groupCount: groupCount)
            }
            else if section == 3 {
                let groupCount: Int = max(self.topSongs.count, 1)
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),  heightDimension: .estimated(90.0*CGFloat(groupCount)))
                return LayoutBuilder.buildSongsSectionLayout(groupSize: groupSize, groupCount: groupCount)
            }
            return LayoutBuilder.buildProfileMainSectionLayout()
        }
        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return socials.count
        }
        else if section == 2 {
            return topArtists.count
        }
        else if section == 3 {
            return topSongs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return CellBuilder.getProfileMainCell(collectionView: collectionView, indexPath: indexPath, data: user!)
        }
        else if indexPath.section == 1 {
            return CellBuilder.getSocialCell(collectionView: collectionView, indexPath: indexPath, social: self.socials[indexPath.item])
        }
        else if indexPath.section == 2 {
            return CellBuilder.getArtistCell(collectionView: collectionView, indexPath: indexPath, data: self.topArtists[indexPath.item]!)
        }
        else if indexPath.section == 3 {
            return CellBuilder.getSongCell(collectionView: collectionView, indexPath: indexPath, data: self.topSongs[indexPath.item]!)
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HomeSectionHeader else {
            fatalError("Could not dequeue HomeSectionHeader")
        }
        if indexPath.section == 2 {
            headerView.configure(text: "Top Artists")
        }
        else if indexPath.section == 3 {
            headerView.configure(text: "Top Songs")
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select a cell here, \(indexPath)")
    }
}

//class ProfileViewController: UIViewController {
//
//    @IBOutlet weak var profilePictureContainer: UIView!
//    @IBOutlet weak var profilePicture: UIImageView!
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var socialsStackView: UIStackView!
//
//    var user: User?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.configure()
//        self.setup()
//    }
//
//    func setup() {
//        self.profilePicture.contentMode = .scaleAspectFill
//        self.profilePicture.clipsToBounds = true
//        self.profilePicture.layer.cornerRadius = profilePicture.frame.width / 2
//        self.profilePicture.image = UIImage(named: "berkeley_home")
//        self.profilePicture.translatesAutoresizingMaskIntoConstraints = false
//
////        self.profilePictureContainer.translatesAutoresizingMaskIntoConstraints = false
////        self.profilePictureContainer.layer.cornerRadius = profilePictureContainer.frame.width / 2
////        self.profilePictureContainer.layer.masksToBounds = false
////        self.profilePictureContainer.layer.shadowColor = UIColor.black.cgColor
////        self.profilePictureContainer.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
////        self.profilePictureContainer.layer.shadowRadius = 1.0
////        self.profilePictureContainer.layer.shadowOpacity = 0.3
//
//
//        nameLabel.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
//        usernameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
//    }
//
//    func configure() {
//        if let user = user {
//            let profilePictureUrl = user.images?[0].url ?? ""
//            if profilePictureUrl != "" {
//                let profilePictureUrlObj = URL(string: profilePictureUrl)
//                profilePicture.kf.setImage(with: profilePictureUrlObj)
//            }
//            nameLabel.text = user.displayName
//            usernameLabel.text = user.id
//
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
//    }
//}
