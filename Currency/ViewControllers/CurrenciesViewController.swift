//
//  CurrenciesViewController.swift
//  Currency
//
//

import UIKit

final class CurrenciesViewController: BaseViewController {
    
    override var titleName: String { "Cryptocurrency" }
    
    var exchangeRate: [Currency] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .currency, value: exchangeRate[indexPath.row])
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
                      let symbol = currency.shortTitle else { return nil }
                
                let price = "$" + String(currency.price)
                let result = ((currency.price - currency.lastPrice) / currency.price) * 100
                let str = String(format: "%.2f", result) + "%"

                return Currency(title: title,
                                symbol: symbol,
                                price: price,
                                lastPrice: str)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Private API

private extension CurrenciesViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedCurrencyViewController(exchangeRate: exchangeRate, selectedIndex: indexPath.row)
        present(vc, animated: true)
    }
}
