//
//  TraitsStarView.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//

import UIKit

class TraitsStarView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starsStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TraitsStarView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func prepareWith(text: String, rating: Int) {
        self.titleLabel.text = text
        
        
        for view in self.starsStackView.subviews {
            view.removeFromSuperview()
        }
        
        for i in 1...5 {
            let star = UIButton()
            star.setTitleColor(.red, for: .normal)
            star.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            star.tag = i
            
            let image = UIImage(named: "star")?.withTintColor(Colors.mainTextColor)
            star.setImage(image, for: .normal)
            if i <= rating {
                let solidImage = UIImage(named: "star-filled")?.withTintColor(Colors.mainTextColor)
                star.setImage(solidImage, for: .normal)
            }
            starsStackView.addArrangedSubview(star)
        }
        
    }


}
