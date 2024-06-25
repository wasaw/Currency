//
//  Extensions.swift
//  Currency
//
//

import UIKit

// MARK: - UIView

extension UIView {
    func anchor(leading: NSLayoutXAxisAnchor? = nil,
                top: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingLeading: CGFloat = 0,
                paddingTop: CGFloat = 0,
                paddingTrailing: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func centerX(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
    }

    func centerY(inView view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    }
}

// MARK: - UserDefaults

extension UserDefaults {
    private enum Keys {
        static let hasLaunchedBefore = "hasLaunchedBefore"
    }

    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: Keys.hasLaunchedBefore)
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: Keys.hasLaunchedBefore)
        }
    }
}

// MARK: - Colors

extension UIColor {
    static let backgroundStartGradient = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 0, green: 4/255, blue: 26/255, alpha: 1)
        case .dark:
            UIColor(red: 0, green: 4/255, blue: 26/255, alpha: 1)
        @unknown default:
            UIColor(red: 0, green: 4/255, blue: 26/255, alpha: 1)
        }
    }
    
    static let backgroundEndGradient = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 75/255, green: 103/255, blue: 108/255, alpha: 1)
        case .dark:
            UIColor(red: 75/255, green: 103/255, blue: 108/255, alpha: 1)
        @unknown default:
            UIColor(red: 75/255, green: 103/255, blue: 108/255, alpha: 1)
        }
    }
    
    static let tabBarBackground = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 0, green: 25/255, blue: 54/255, alpha: 1)
        case .dark:
            UIColor(red: 0, green: 25/255, blue: 54/255, alpha: 1)
        @unknown default:
            UIColor(red: 0, green: 25/255, blue: 54/255, alpha: 1)
        }
    }
    
    static let titleColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 19/255, green: 28/255, blue: 46/255, alpha: 1)
        case .dark:
            UIColor(red: 19/255, green: 28/255, blue: 46/255, alpha: 1)
        @unknown default:
            UIColor(red: 19/255, green: 28/255, blue: 46/255, alpha: 1)
        }
    }
    
    static let priceColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        case .dark:
            UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        @unknown default:
            UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1)
        }
    }
    
    static let shortCurrencyColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        case .dark:
            UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        @unknown default:
            UIColor(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        }
    }
    
    static let separatorCellColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        case .dark:
            UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        @unknown default:
            UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        }
    }
    
    static let policyTextColor = UIColor { traitCollection in
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            UIColor(red: 100/255, green: 117/255, blue: 139/255, alpha: 1)
        case .dark:
            UIColor(red: 100/255, green: 117/255, blue: 139/255, alpha: 1)
        @unknown default:
            UIColor(red: 100/255, green: 117/255, blue: 139/255, alpha: 1)
        }
    }
}
