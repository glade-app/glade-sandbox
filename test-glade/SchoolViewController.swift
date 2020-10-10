//
//  SchoolViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit


class testScrollViewController: UIViewController, UIScrollViewDelegate {
    let images = ["mad", "angry", "swearing", "sad"].shuffled()
    var contentWidth: CGFloat = 0.0
    
    @IBOutlet weak var schoolScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        schoolScrollView.delegate = self
        
        for i in 0...(images.count - 1) {
            let imageToDisplay = UIImage(named: "\(images[i]).png")
            let imageView = UIImageView(image: imageToDisplay)
            
            schoolScrollView.addSubview(imageView)
            contentWidth += view.frame.width
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(i) - 50
            
            imageView.frame = CGRect(x: xCoordinate, y: view.frame.height / 2, width: 100, height: 100)
        }
        
        schoolScrollView.contentSize = CGSize(width: contentWidth, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
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
