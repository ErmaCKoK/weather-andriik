//
//  UIImageView+Download.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/29/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

extension UIImageView {
    
    private struct AssociatedKeys {
        static var url = "UIImageView+Download.url"
    }
    
    private var url: String? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.url) as? String }
        set { objc_setAssociatedObject(self, &AssociatedKeys.url, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    func setImage(with url: String?) {
        
        self.image = nil
        self.url = url
        
        guard let url = url else { return }
        
        Networking.image(with: url) { (image) in
            DispatchQueue.main.async {
                if self.url != url { return }
                self.image = image
            }
        }
    }
    
}
