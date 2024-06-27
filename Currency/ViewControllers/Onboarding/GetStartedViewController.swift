//
//  GetStartedViewController.swift
//  Currency
//
//

import UIKit

final class GetStartedViewController: BaseOnboardingViewController {
    override var txtTitle: String { "Get Started" }
    override var txtImage: String { "Start" }
    override var txtDescription: String { "Your trusted companion in the world of cryptocurrencies! Convenient and intuitive way to track cryptocurrency prices in real-time. Get up-to-date information on prices, charts, and important market news right on your device." }
    override var txtBtn: String { "Next" }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let attributedString = NSMutableAttributedString(string: txtDescription)
        let highlightColor = UIColor.seletedColor
        let range = (txtDescription as NSString).range(of: "companion")
        let secondRange = (txtDescription as NSString).range(of: "real-time")
        attributedString.addAttribute(.foregroundColor, value: highlightColor, range: range)
        attributedString.addAttribute(.foregroundColor, value: highlightColor, range: secondRange)
        
        lblDescription.attributedText = attributedString
    }
    
    override func handleNext() {
        navigationController?.pushViewController(FavouritesListViewController(), animated: true)
    }
}
