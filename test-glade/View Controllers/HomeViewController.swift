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
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.makeLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeSchoolCollectionViewCell.self, forCellWithReuseIdentifier: "school")
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: "user")
        collectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "song")
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "artist")
        collectionView.register(HomeSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var schoolData: [String: Any] = ["userCount": 0]
    var currentUser: User?
    var users: [User?] = []
    var topArtists: [Artist?] = []
    var topSongs: [Song?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getSchoolData()
        self.getCurrentUser() { (result) in
            self.getArtistsData()
            self.getSongsData()
        }
        self.setup()
        self.refreshCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    func refreshCollectionView() {
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
    func setup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped(sender:)))
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        collectionView.reloadData()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
    @objc func profileButtonTapped(sender: UIBarButtonItem) {
        print("Profile button tapped")
        self.displayProfile(user: self.currentUser!)
    }
    
    func getCurrentUser(completion: @escaping (_ result: Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        DataStorage.getUserData(username: username!) { (result, user) in
            self.currentUser = user
            DispatchQueue.main.async {
                self.refreshCollectionView()
            }
            completion(true)
        }
    }
    
    func getSchoolData() {
        DataStorage.getSchoolUsersData { (result, data) in
            self.schoolData = data
            var userIDs: [String] = data["users"]! as! [String]
            userIDs.shuffle()
            let group = DispatchGroup()
            for userID in userIDs {
                if userID != self.currentUser!.id! {
                    group.enter()
                    DataStorage.getUserData(username: userID) { (result, user) in
                        self.users.append(user)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) {
                DispatchQueue.main.async {
                    self.refreshCollectionView()
                }
            }
        }
    }
    
    func getArtistsData() {
        DataStorage.getSchoolTopArtists(count: 10) { (result, artists) in
            self.topArtists = artists
            DispatchQueue.main.async {
                self.refreshCollectionView()
            }
        }
    }
    
    func getSongsData() {
        DataStorage.getSchoolTopSongs(count: 10) { (result, songs) in
            self.topSongs = songs
            DispatchQueue.main.async {
                self.refreshCollectionView()
            }
        }
    }
    
    func displayProfile(user: User) {
        if let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        {
            profileVC.user = user
            self.present(profileVC, animated: true, completion: nil)
        }
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if section == 0 {
                return LayoutBuilder.buildSchoolSectionLayout(size: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)))
            }
            else if section == 1 {
                return LayoutBuilder.buildUsersSectionLayout()
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
            return LayoutBuilder.buildUsersSectionLayout()
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
            return self.users.count
        }
        else if section == 2 {
            return self.topArtists.count
        }
        else if section == 3 {
            return self.topSongs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return CellBuilder.getSchoolCell(collectionView: collectionView, indexPath: indexPath, data: self.schoolData)
        }
        else if indexPath.section == 1 {
            return CellBuilder.getUserCell(collectionView: collectionView, indexPath: indexPath, data: self.users[indexPath.item]!)
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
        if indexPath.section == 1 {
            let userTapped = self.users[indexPath.item]!
            self.displayProfile(user: userTapped)
        }
    }
}
