//
//  StatView.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class schoolStatsView: UIView {
    
    @IBOutlet var contentView: UIView!
        
    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var statCategory1Label: UILabel!
    @IBOutlet weak var statValue1Label: UILabel!
    @IBOutlet weak var statCategory2Label: UILabel!
    @IBOutlet weak var statValue2Label: UILabel!
    
    func configure(schoolName: String, category1: String, value1: Int, category2: String, value2: Int, image: UIImage) {
        schoolLabel.text = schoolName
        schoolImageView.image = image
        statCategory1Label.text = category1
        statValue1Label.text = "\(value1)"
        statCategory2Label.text = category2
        statValue2Label.text = "\(value2)"
        
        schoolImageView.contentMode = .scaleAspectFill
        schoolLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        statCategory1Label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        statValue1Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        statCategory2Label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        statValue2Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
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
        let nib = UINib(nibName: "StatView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        contentView.backgroundColor = UIColor.clear
        addSubview(contentView)
    }
}
