//
//  FavouritesListViewController.swift
//  Currency
//
//

import UIKit

final class FavouritesListViewController: BaseOnboardingViewController {
    override var txtTitle: String { "Favorites list" }
    override var txtImage: String { "Favourites" }
    override var txtDescription: String { "Add cryptocurrencies to your favorites list for quick access and personalized tracking of your preferred digital assets." }
    override var txtBtn: String { "Next" }
    
    override func handleNext() {
        navigationController?.pushViewController(AlertsNotificationsViewController(), animated: true)
    }
}
