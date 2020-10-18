//
//  StatView.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class SchoolStatsView: UIView {
    
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
        schoolLabel.textColor = UIColor.white
        statCategory1Label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        statCategory1Label.textColor = UIColor.white
        statValue1Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        statValue1Label.textColor = UIColor.white
        statCategory2Label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        statCategory2Label.textColor = UIColor.white
        statValue2Label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        statValue2Label.textColor = UIColor.white
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
        let nib = UINib(nibName: "SchoolStatsView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
}
