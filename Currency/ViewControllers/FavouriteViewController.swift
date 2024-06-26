//
//  FavouriteViewController.swift
//  Currency
//
//

import UIKit

final class FavouriteViewController: BaseViewController {
    
    override var titleName: String { "Favourite" }
    var exchangeRate: [CurrencyPreview] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .favourite, value: exchangeRate[indexPath.row])
        return cell
    }
    
// MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let result = CurrencyService.shared.fetchCurrency() {
            exchangeRate = result.compactMap({ currency in
                return currency.isFavourite ? currency : nil
            })
        }
    }
}
