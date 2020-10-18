//
//  Home2ViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/18/20.
//

import UIKit

class HomeViewController: UIViewController {
    let data = Array.init(repeating: ("Berkeley", UIImage(named: "berkeley2")!), count: 10)
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerNibs()
        self.homeCollectionView.delegate = self
        self.homeCollectionView.dataSource = self
    }
    
    func registerNibs() {
        let nib = UINib(nibName: SchoolHomeCollectionViewCell.nibName, bundle: nil)
        homeCollectionView?.register(nib, forCellWithReuseIdentifier: SchoolHomeCollectionViewCell.reuseIdentifier)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SchoolHomeCollectionViewCell.reuseIdentifier, for: indexPath) as! SchoolHomeCollectionViewCell
            let imageToDisplay = UIImage(named: "berkeley2")!
            cell.configure(schoolName: "UC Berkeley", category1: "Members", value1: 123, category2: "Plays", value2: 9999, image: imageToDisplay)
            return cell
        }
//        else if indexPath.item == 1 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifier, for: indexPath)
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .horizontal
//            let horizontalView = HorizontalCollectionView(frame: cell.frame, collectionViewLayout: layout, data: data)
//            cell.addSubview(horizontalView)
//            return cell
//        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let collectionCellWidth: CGFloat = view.frame.width
            let collectionCellHeight: CGFloat = 300
            return CGSize(width: collectionCellWidth, height: collectionCellHeight)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    // Changes spacing between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }
    // Not really sure what this does? Might change vertical spacing but probably won't be useful for us
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Changes the left and right end points of the collection view (where the cells start and end)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
