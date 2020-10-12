//
//  ScrollViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit

class ScrollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let images = ["berkeley.jpg", "stanford.jpg", "harvard.jpg", "princeton.jpg"]
    let imageNames = ["UC Berkeley", "Stanford", "Harvard", "Princeton"]
    
    @IBOutlet weak var schoolCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toAccountCreation", sender: self)
    }
    
    func registerNib() {
        let nib = UINib(nibName: SchoolCollectionViewCell.nibName, bundle: nil)
        schoolCollectionView?.register(nib, forCellWithReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier)
    }
    
    // Returns number of rows (1)
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Returns the number of images (schools)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // Creates cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = schoolCollectionView.dequeueReusableCell(withReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier, for: indexPath) as! SchoolCollectionViewCell
        let imageToDisplay = UIImage(named: images[indexPath.item])
        cell.configureCell(schoolName: imageNames[indexPath.item], image: imageToDisplay!)
        return cell
    }
    
    // Action on tap (currently prints the school name corresponding to the image)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(imageNames[indexPath.item])
    }
    
    // Sets cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: SchoolCollectionViewCell = Bundle.main.loadNibNamed(SchoolCollectionViewCell.nibName, owner: self, options: nil)?.first as? SchoolCollectionViewCell else {
            return CGSize.zero
        }
        let imageToDisplay = UIImage(named: images[indexPath.item])
        cell.configureCell(schoolName: imageNames[indexPath.item], image: imageToDisplay!)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let collectionCellWidth: CGFloat = collectionView.bounds.size.width * 3/4
        let collectionCellHeight: CGFloat = collectionView.bounds.size.height
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
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
        return UIEdgeInsets.init(top: 0, left: collectionView.bounds.size.width * 1/8, bottom: 0, right: collectionView.bounds.size.width * 1/8)
    }
}
