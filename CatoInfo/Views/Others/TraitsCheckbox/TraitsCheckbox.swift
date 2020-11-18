//
//  TraitsCheckbox.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//

import UIKit

class TraitsCheckbox: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TraitsCheckbox", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func prepareWith(text: String, value: Bool) {
        self.titleLabel.text = text
        
        if value {
            self.imageView.image = UIImage(named: "tick")?.withTintColor(.black)
        } else {
            self.imageView.image = UIImage(named: "cross")?.withTintColor(.black)
        }
        
    }
    
}
