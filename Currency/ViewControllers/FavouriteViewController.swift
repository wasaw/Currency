//
//  FavouriteViewController.swift
//  Currency
//
//

import UIKit

final class FavouriteViewController: BaseViewController {
    
    override var titleName: String { "Favourite" }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .favourite)
        return cell
    }
}
