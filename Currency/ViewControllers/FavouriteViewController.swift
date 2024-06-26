//
//  FavouriteViewController.swift
//  Currency
//
//

import UIKit

final class FavouriteViewController: BaseViewController {
    
    override var titleName: String { "Favourite" }
    var exchangeRate: [Currency] = []
    
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
        
        exchangeRate = []

        do {
            let currencyManagedObject = try CoreDataService().fetchCurrency()
            exchangeRate = currencyManagedObject.compactMap({ currency in
                guard let title = currency.title,
                      let symbol = currency.shortTitle,
                      currency.isFavourite == true  else { return nil }
                                
                let price = "$" + String(currency.price)
                let result = ((currency.price - currency.lastPrice) / currency.price) * 100
                let str = String(format: "%.2f", result) + "%"

                return Currency(title: title,
                                symbol: symbol,
                                price: price,
                                lastPrice: str,
                                isFavourite: currency.isFavourite)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}
