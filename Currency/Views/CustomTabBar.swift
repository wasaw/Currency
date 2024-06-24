//
//  CustomTabBar.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let radius: CGFloat = 35.48
}

final class CustomTabBar: UITabBar {
    
// MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let roundedLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight], 
                                cornerRadii: CGSize(width: Constants.radius, height: Constants.radius))
        roundedLayer.path = path.cgPath
        roundedLayer.fillColor = UIColor.tabBarBackground.cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = path.cgPath
        shadowLayer.fillColor = UIColor.clear.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 10.0
        
        if let oldLayer = layer.sublayers?.first, oldLayer.name == "roundedLayer" {
            layer.replaceSublayer(oldLayer, with: roundedLayer)
        } else {
            roundedLayer.name = "roundedLayer"
            layer.insertSublayer(roundedLayer, at: 0)
        }
        
        if let oldShadowLayer = layer.sublayers?.first(where: { $0.name == "shadowLayer" }) {
            layer.replaceSublayer(oldShadowLayer, with: shadowLayer)
        } else {
            shadowLayer.name = "shadowLayer"
            layer.insertSublayer(shadowLayer, below: roundedLayer)
        }
    }
}
