//
//  HomeTwoViewController.swift
//  test-glade
//
//  Created by Allen Gu on 11/16/20.
//

// https://lickability.com/blog/getting-started-with-uicollectionviewcompositionallayout/
// https://dev.to/kevinmaarek/replicating-the-appstore-s-collectionviewlayout-orthogonal-in-swift-5-42je

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeSchoolCollectionViewCell.self, forCellWithReuseIdentifier: "school")
        collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "song")
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "artist")
        collectionView.register(HomeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var schoolData: [String: Any] = ["userCount": 0]
    var topArtists: [Artist?] = []
    var topSongs: [Song?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
        self.getSchoolData()
        self.getArtistsData()
        self.getSongsData()
    }
    
    func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped(sender:)))
        
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    @objc func profileButtonTapped(sender: UIBarButtonItem) {
        print("Profile button tapped")
        
        // Safe Present
        if let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        {
            let username = UserDefaults.standard.string(forKey: "username")
            DataStorage.getUserData(username: username!) { (result, user) in
                profileVC.user = user
                self.present(profileVC, animated: true, completion: nil)
                profileVC.loadSocials()
                profileVC.loadUserTopArtists()
                profileVC.loadUserTopSongs()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func getSchoolData() {
        DataStorage.getSchoolData { (result, data) in
            self.schoolData = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getArtistsData() {
        DataStorage.getSchoolTopArtists(count: 10) { (result, artists) in
            self.topArtists = artists
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getSongsData() {
        DataStorage.getSchoolTopSongs(count: 20) { (result, songs) in
            self.topSongs = songs
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if section == 0 {
                return LayoutBuilder.buildSchoolSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)))
            }
//            else if section == 1 {
//                return HomeLayoutBuilder.buildArtistSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(240)))
//            }
            
            else if section == 1 {
                return LayoutBuilder.buildArtistsSectionLayout()
            }
            
//            else if section == 2 {
//                return HomeLayoutBuilder.buildSongSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250)))
//            }
            else if section == 2 {
                return LayoutBuilder.buildSongsSectionLayout()
            }
            return LayoutBuilder.buildSongsSectionLayout()
        }
        return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return self.topArtists.count
        }
//        else if section == 2 {
//            return self.topSongs.count
//        }
        else if section == 2 {
            return self.topSongs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return CellBuilder.getSchoolCell(collectionView: collectionView, indexPath: indexPath, data: self.schoolData)
        }
        else if indexPath.section == 1 {
            return CellBuilder.getArtistCell(collectionView: collectionView, indexPath: indexPath, data: self.topArtists[indexPath.item]!)
        }
        else if indexPath.section == 2 {
            return CellBuilder.getSongCell(collectionView: collectionView, indexPath: indexPath, data: self.topSongs[indexPath.item]!)
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HomeSectionHeader else {
            fatalError("Could not dequeue HomeSectionHeader")
        }
        
        if indexPath.section == 1 {
            headerView.configure(text: "Top Artists")
        }
        
        else if indexPath.section == 2 {
            headerView.configure(text: "Top Songs")
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select a cell here, \(indexPath)")
    }
}
