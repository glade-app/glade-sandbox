//
//  ContainerCollectionViewCell.swift
//  test-glade
//
//  Created by Allen Gu on 10/18/20.
//

import UIKit

class ContainerCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var data: [Any]?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    class var reuseIdentifier: String {
        return "ContainerCollectionViewCellReuseIdentifier"
    }
    class var nibName: String {
        return "ContainerCollectionViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNib()
    }

    func registerNib() {
        let horizontalNib = UINib(nibName: HorizontalCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(horizontalNib, forCellWithReuseIdentifier: HorizontalCollectionViewCell.reuseIdentifier)
    }
    
    func configure(category: String, data: [Any]) {
        print("horizontal collection view configured")
        titleLabel.text = category
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("here in cellforitemat in container")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.reuseIdentifier, for: indexPath) as! HorizontalCollectionViewCell
        let dataToUse = self.data as! [(String, String, UIImage)]
        print(dataToUse)
        cell.configure(name: dataToUse[indexPath.item].0, description: dataToUse[indexPath.item].1, image: dataToUse[indexPath.item].2)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.bounds.height)
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
        }

    // Changes vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // Changes the left and right end points of the collection view (where the cells start and end)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 40, bottom: 0, right: 40)
    }
}
