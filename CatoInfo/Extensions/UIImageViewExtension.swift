//
//  UIImageViewExtension.swift
//  CatoInfo
//
//  Created by Ogonowski, Dawid (external - Project) on 06/11/2020.
//

import UIKit


extension UIImageView {
    public func imageFromURL(urlString: String, placeholderImage : UIImage?) {

        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        activityIndicator.color = .lightGray
        self.image = placeholderImage
        self.addSubview(activityIndicator)

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                }
                print("⚠️ SETTING IMAGE ERROR: \(error)")
                return
            }

            if let data = data {
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data)
                    activityIndicator.removeFromSuperview()
                    self.image = image
                })
            }
        }).resume()
    }
}
