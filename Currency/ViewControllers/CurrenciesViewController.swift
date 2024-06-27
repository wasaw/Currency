//
//  CurrenciesViewController.swift
//  Currency
//
//

import UIKit

final class CurrenciesViewController: BaseViewController {
    
// MARK: - Properties
    
    override var titleName: String { "Cryptocurrency" }
    
    var exchangeRate: [CurrencyPreview] = []
    private var filteredExchangeRate: [CurrencyPreview] = []
    
// MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredExchangeRate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .currency, value: filteredExchangeRate[indexPath.row])
        return cell
    }
    
// MARK: - UITextFieldDelegate
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        filterData(searchText: updatedText)
        
        return true
    }
    
// MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let result = CurrencyService.shared.fetchCurrency() {
            exchangeRate = result
            filteredExchangeRate = result
        }
    }
}

// MARK: - Private API

private extension CurrenciesViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SelectedCurrencyViewController(exchangeRate: exchangeRate, selectedIndex: indexPath.row)
        present(vc, animated: true)
    }
    
    func filterData(searchText: String) {
        if searchText.isEmpty {
            filteredExchangeRate = exchangeRate
        } else {
            filteredExchangeRate = exchangeRate.filter{ $0.title.lowercased().contains(searchText.lowercased()) }
        }
        tvCurrency.reloadData()
    }
}
