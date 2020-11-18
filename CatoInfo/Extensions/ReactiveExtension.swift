//
//  ReactiveExtension.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 27/10/2020.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

extension Reactive where Base: UIViewController {
    
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        })
    }
    
}
