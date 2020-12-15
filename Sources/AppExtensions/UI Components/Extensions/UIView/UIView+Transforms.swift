//
//  UIView+Transforms.swift
//  
//
//  Created by Cristian Carlassare on 11/12/2020.
//

import UIKit


public extension UIView {
    
    func makeCircle() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
}
