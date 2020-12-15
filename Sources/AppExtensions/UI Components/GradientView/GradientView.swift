//
//  GradientView.swift
//  
//
//  Created by Rodrigo Cian Berrios on 25/11/2020.
//

import Foundation
import UIKit

@IBDesignable
open class GradientView: UIView {

    @IBInspectable public var leftColor: UIColor = UIColor.white {
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable public var rightColor: UIColor = UIColor.white {
        didSet {
            updateGradientColors()
        }
    }

    @IBInspectable public var startPoint: CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            updateGradientDirection()
        }
    }

    @IBInspectable public var endPoint: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            updateGradientDirection()
        }
    }

    public var locations: [CGFloat] = [0.0, 1.0] {
        didSet {
            updateLocations()
        }
    }

    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradient()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGradient()
    }

    private func addGradient() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.masksToBounds = true
        updateGradientColors()
        updateGradientDirection()
    }

    private func updateGradientColors() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.colors = [leftColor.cgColor, rightColor.cgColor]
    }

    private func updateGradientDirection() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.startPoint = startPoint
        layer.endPoint = endPoint
    }

    private func updateLocations() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.locations = locations as [NSNumber]
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientColors()
        updateGradientDirection()
        updateLocations()
    }
}
