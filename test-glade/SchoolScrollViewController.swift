//
//  SchoolScrollViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/10/20.
//

import UIKit

class SchoolScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var schoolScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
   
    var contentWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let images = ["berkeley.jpg", "stanford.jpg", "harvard.jpg", "princeton.jpg"]
        let imageNames = ["UC Berkeley", "Stanford", "Harvard", "Princeton"]
        
//        let images = ["berkeley.jpg"]
//        let imageNames = ["UC Berkeley"]
        
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        schoolScrollView.delegate = self
        var imageView: SchoolView!
        let subviewWidth = view.frame.width * 0.75
        contentWidth = (view.frame.width - subviewWidth) / 2
        
        for i in 0...(images.count - 1) {
            imageView = SchoolView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: schoolScrollView.frame.height))
            schoolScrollView.addSubview(imageView)
            
            let imageToDisplay = UIImage(named: "\(images[i])")
            imageView.image = imageToDisplay
            imageView.schoolName = imageNames[i]
            
            let xCoordinate = contentWidth
            contentWidth += subviewWidth
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: subviewWidth, height: schoolScrollView.frame.height)
            
           
        }
        contentWidth += (view.frame.width - subviewWidth) / 2
        schoolScrollView.contentSize = CGSize(width: contentWidth, height: schoolScrollView.frame.height)
    }

    @IBAction func toAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "toAccountCreation", sender: self)
    }
}
