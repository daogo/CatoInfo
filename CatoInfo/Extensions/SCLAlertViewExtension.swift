//
//  SCLAlertView.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 26/10/2020.
//

import Foundation
import SCLAlertView

extension SCLAlertView {
    func showCustomError(error: Error) {
        SCLAlertView().showError("Error", subTitle: (error as? APIError)?.localizedDescription ?? "Something went wrong..." )
    }
}


