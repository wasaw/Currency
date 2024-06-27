//
//  AlertViewController.swift
//  Currency
//
//

import UIKit

final class AlertViewController: BaseViewController {
    
// MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideSearch()
    }
    
    override var titleName: String { "Alerts" }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .alert)
        return cell
    }
}
