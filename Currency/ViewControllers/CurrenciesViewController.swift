//
//  CurrenciesViewController.swift
//  Currency
//
//

import UIKit

final class CurrenciesViewController: BaseViewController {
    
    override var titleName: String { "Cryptocurrency" }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .currency)
        return cell
    }
}
