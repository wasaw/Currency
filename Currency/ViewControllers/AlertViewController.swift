//
//  AlertViewController.swift
//  Currency
//
//

import UIKit

final class AlertViewController: BaseViewController {
    
    private var alertCurrency: [AlertPreview] = []
    
// MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        load()
        hideSearch()
    }
    
    override var titleName: String { "Alerts" }
    
// MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertCurrency.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        cell.configure(for: .alert, value: alertCurrency[indexPath.row])
        return cell
    }
}

// MARK: - Private API

private extension AlertViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let customAlertVC = ChangeAlertViewController(currency: alertCurrency[indexPath.row])
        customAlertVC.modalPresentationStyle = .overFullScreen
        customAlertVC.modalTransitionStyle = .crossDissolve
        customAlertVC.delegate = self
        present(customAlertVC, animated: true, completion: nil)
    }
    
    func load() {
        if let result = CurrencyService.shared.fetchAlert() {
            alertCurrency = result
        }
        
        tvCurrency.reloadData()
    }
}

// MARK: - AlertDelegate

extension AlertViewController: AlertDelegate {
    func update() {
        load()
    }
}
