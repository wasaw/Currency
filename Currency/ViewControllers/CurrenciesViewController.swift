//
//  CurrenciesViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let radius: CGFloat = 32.58
    static let titlePadding: CGFloat = 20.0
    static let tvPadding: CGFloat = 20.0
    static let rowHeight: CGFloat = 74.0
}

final class CurrenciesViewController: UIViewController {
    
// MARK: - Properties
    
    private lazy var vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Cryptocurrency"
        label.font = UIFont(name: "MulishRoman-Medium", size: 27)
        label.textColor = .titleColor
        return label
    }()
    
    private lazy var tvCurrency = UITableView(frame: .zero)
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.backgroundStartGradient.cgColor, UIColor.backgroundEndGradient.cgColor]
        gradientLayer.locations = [0.0, 1.4, 1.7]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        configureUI()
    }
}

// MARK: - Private API

private extension CurrenciesViewController {
    func configureUI() {
        view.addSubview(vContent)
        vContent.anchor(leading: view.leadingAnchor, 
                           top: view.safeAreaLayoutGuide.topAnchor,
                           trailing: view.trailingAnchor,
                           bottom: view.bottomAnchor)
        vContent.layer.cornerRadius = Constants.radius
        
        vContent.addSubview(lblTitle)
        lblTitle.centerX(inView: vContent)
        lblTitle.anchor(top: vContent.topAnchor, paddingTop: Constants.titlePadding)
        
        configureTableView()
    }
    
    func configureTableView() {
        tvCurrency.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseIdentifire)
        tvCurrency.dataSource = self
        tvCurrency.delegate = self
        tvCurrency.rowHeight = Constants.rowHeight
        tvCurrency.separatorStyle = .none
        vContent.addSubview(tvCurrency)
        tvCurrency.anchor(leading: vContent.leadingAnchor,
                          top: lblTitle.bottomAnchor,
                          trailing: vContent.trailingAnchor,
                          bottom: vContent.bottomAnchor,
                          paddingLeading: Constants.tvPadding,
                          paddingTop: Constants.tvPadding,
                          paddingTrailing: -Constants.tvPadding)
        tvCurrency.backgroundColor = .white
    }
}

// MARK: - UITableViewDataSource

extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CurrenciesViewController: UITableViewDelegate {
    
}
