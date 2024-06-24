//
//  AlertViewController.swift
//  Currency
//
//

import UIKit

final class AlertViewController: BaseViewController {
    
    override var titleName: String { "Alerts" }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .alert)
        return cell
    }
}
