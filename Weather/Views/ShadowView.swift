//
//  ShadowView.swift
//  Weather
//
//  Created by Andrii Kurshyn on 5/29/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.08
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // for perfomerce issues we set bezier path
        // and should resize this bezier path when did layout subviews becouse bezier path no auto resize
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
