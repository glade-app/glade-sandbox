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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toAccountCreation", sender: self)
    }
    
    func registerNib() {
        let nib = UINib(nibName: SchoolCollectionViewCell.nibName, bundle: nil)
        schoolCollectionView?.register(nib, forCellWithReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = schoolCollectionView.dequeueReusableCell(withReuseIdentifier: SchoolCollectionViewCell.reuseIdentifier, for: indexPath) as! SchoolCollectionViewCell
        let imageToDisplay = UIImage(named: images[indexPath.item])
        cell.configureCell(schoolName: imageNames[indexPath.item], image: imageToDisplay!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.init(top: 0, left: collectionView.bounds.size.width * 1/8, bottom: 0, right: collectionView.bounds.size.width * 1/8)
        }
}
