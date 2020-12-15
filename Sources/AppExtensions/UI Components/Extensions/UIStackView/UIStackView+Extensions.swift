//
//  UIStackView+Extensions.swift
//  
//
//  Created by Cristian Carlassare on 10/12/2020.
//

import UIKit


public extension UIStackView {
    
    func removeArrangedSubViews() {
        for view in self.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
