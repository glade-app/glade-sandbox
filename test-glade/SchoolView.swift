//
//  SchoolView.swift
//  test-glade
//
//  Created by Allen Gu on 10/10/20.
//

import UIKit

class SchoolView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var schoolName: String? {
        get { return label?.text }
        set { label.text = newValue }
    }
    
    var image: UIImage? {
        get {return imageView.image}
        set {imageView.image = newValue}
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "SchoolView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        label.textColor = UIColor.white
        imageView.layer.cornerRadius = 20
    }
}
