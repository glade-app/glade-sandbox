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
    let imagePadding: CGFloat = 10
    var contentWidth: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let images = ["berkeley.jpg", "stanford.jpg", "harvard.jpg", "princeton.jpg"]
        let imageNames = ["UC Berkeley", "Stanford", "Harvard", "Princeton"]
        
//        let image = UIImage(named: "minimalist_landscape4.png")
//        imageView.label.text = "UC Berkeley"
//        imageView.imageView.image = image
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        schoolScrollView.delegate = self
        var imageView: SchoolView!
        for i in 0...(images.count - 1) {
            imageView = SchoolView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: schoolScrollView.frame.height))
            let imageToDisplay = UIImage(named: "\(images[i])")
            imageView.image = imageToDisplay
            imageView.schoolName = imageNames[i]
            
            schoolScrollView.addSubview(imageView)
            contentWidth += view.frame.width
            let xCoordinate = contentWidth - view.frame.width
            imageView.frame = CGRect(x: xCoordinate, y: imagePadding, width: view.frame.width - 2 * imagePadding, height: schoolScrollView.frame.height - 2 * imagePadding)
        }
        
        schoolScrollView.contentSize = CGSize(width: contentWidth, height: schoolScrollView.frame.height)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
