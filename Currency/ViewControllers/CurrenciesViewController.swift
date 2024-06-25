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
        guard let url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETC,BTC,ETH&tsyms=USD") else { return }
        let request = URLRequest(url: url)
        Network().loadData(request: request) { [weak self] (result: Result<CurrencyDataModel, Error>) in
            switch result {
            case .success(let result):
                self?.exchangeRate.append(Currency(title: "Ethereum Classic",
                                                   symbol: result.display.etc.usd.fromsymbol,
                                                   price: result.display.etc.usd.price))
                self?.exchangeRate.append(Currency(title: "Bitcoin",
                                                   symbol: result.display.btc.usd.fromsymbol,
                                                   price: result.display.btc.usd.price))
                self?.exchangeRate.append(Currency(title: "Ethereum",
                                                   symbol: result.display.eth.usd.fromsymbol,
                                                   price: result.display.eth.usd.price))
                DispatchQueue.main.async {
                    self?.tvCurrency.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
}
