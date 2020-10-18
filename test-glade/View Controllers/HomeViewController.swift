//
//  Home2ViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/18/20.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNibs()
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
        
        self.setup()
    }
    
    func registerNibs() {
        let schoolNib = UINib(nibName: SchoolHomeCollectionViewCell.nibName, bundle: nil)
        homeCollectionView?.register(schoolNib, forCellWithReuseIdentifier: SchoolHomeCollectionViewCell.reuseIdentifier)
        let containerNib = UINib(nibName: ContainerCollectionViewCell.nibName, bundle: nil)
        homeCollectionView?.register(containerNib, forCellWithReuseIdentifier: ContainerCollectionViewCell.reuseIdentifier)
        let horizontalNib = UINib(nibName: HorizontalCollectionViewCell.nibName, bundle: nil)
        homeCollectionView?.register(horizontalNib, forCellWithReuseIdentifier: HorizontalCollectionViewCell.reuseIdentifier)
    }
    
    func setup() {
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: SchoolHomeCollectionViewCell.reuseIdentifier, for: indexPath) as! SchoolHomeCollectionViewCell
            let imageToDisplay = UIImage(named: "berkeley2")!
            cell.configure(schoolName: "UC Berkeley", category1: "Members", value1: 123, category2: "Plays", value2: 9999, image: imageToDisplay)
            return cell
        }
        else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCollectionViewCell.reuseIdentifier, for: indexPath) as! ContainerCollectionViewCell
            // Propagate with data
            let data = Array.init(repeating: ("Song", "Description", UIImage(named: "berkeley2")!), count: 10)
            cell.configure(category: "Top Songs", data: data)
            return cell
        }
        else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContainerCollectionViewCell.reuseIdentifier, for: indexPath) as! ContainerCollectionViewCell
            // Propagate with data
            let data = Array.init(repeating: ("Artist", "Description", UIImage(named: "berkeley2")!), count: 10)
            cell.configure(category: "Top Artists", data: data)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let collectionCellWidth: CGFloat = view.frame.width
            let collectionCellHeight: CGFloat = 300
            return CGSize(width: collectionCellWidth, height: collectionCellHeight)
        }
        else if indexPath.item == 1 || indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
    
    // Changes vertical spacing between each cell (vertical scrolling)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 30
        }
    // Not really sure what this does? Might change vertical spacing but probably won't be useful for us
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Changes the left and right end points of the collection view (where the cells start and end)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 40, right: 0)
    }
}
