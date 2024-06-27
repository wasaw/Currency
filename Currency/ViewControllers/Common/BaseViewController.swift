//
//  BaseViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let radius: CGFloat = 32.58
    static let titlePadding: CGFloat = 20.0
    static let tvPadding: CGFloat = 20.0
    static let rowHeight: CGFloat = 74.0
    static let vSearchPaddingTop: CGFloat = 10.0
    static let vSearchWidth: CGFloat = 200.0
    static let vSearchHeight: CGFloat = 38.0
    static let ivSearchDimensions: CGFloat = 15.0
    static let ivSearchPaddingLeading: CGFloat = 39.0
    static let tfSearchPaddingHorizontal: CGFloat = 10.0
    static let vSeparatorHeight: CGFloat = 1.0
}

class BaseViewController: UIViewController {
    
// MARK: - Properties
    
    var titleName: String { "" }
    
    private lazy var vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.text = titleName
        label.font = UIFont(name: "MulishRoman-Medium", size: 27)
        label.textColor = .titleColor
        return label
    }()
    
    private lazy var vSearch: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var ivSearch: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Search")
        return iv
    }()
    
    private lazy var tfSearch: UITextField = {
        let tf = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "MulishRoman-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "Find coins...", attributes: placeholderAttributes)
        tf.textColor = .black
        tf.delegate = self
        return tf
    }()
    
    private lazy var vSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorCellColor
        return view
    }()
    
    private var vSearchHeightConstraint: NSLayoutConstraint?
    
    lazy var tvCurrency = UITableView(frame: .zero)
    
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
    
// MARK: - Helpers
    
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
        
        configureSearch()
        configureTableView()
    }
}

// MARK: - Private API

private extension BaseViewController {
    
    func configureSearch() {
        vContent.addSubview(vSearch)
        vSearch.centerX(inView: vContent)
        vSearch.anchor(top: lblTitle.bottomAnchor,
                       paddingTop: Constants.vSearchPaddingTop,
                       width: Constants.vSearchWidth,
                       height: Constants.vSearchHeight)
        vSearchHeightConstraint = vSearch.heightAnchor.constraint(equalToConstant: Constants.vSearchWidth)
        vSearchHeightConstraint?.isActive = true
        
        vSearch.addSubview(ivSearch)
        ivSearch.centerY(inView: vSearch)
        ivSearch.anchor(leading: vSearch.leadingAnchor,
                        paddingLeading: Constants.ivSearchPaddingLeading,
                        width: Constants.ivSearchDimensions,
                        height: Constants.ivSearchDimensions)
        
        vSearch.addSubview(tfSearch)
        tfSearch.centerY(inView: vSearch)
        tfSearch.anchor(leading: ivSearch.trailingAnchor, trailing: vSearch.trailingAnchor, paddingLeading: Constants.tfSearchPaddingHorizontal, paddingTrailing: -Constants.tfSearchPaddingHorizontal)
        
        vSearch.addSubview(vSeparator)
        vSeparator.anchor(leading: vSearch.leadingAnchor,
                          trailing: vSearch.trailingAnchor,
                          bottom: vSearch.bottomAnchor,
                          height: Constants.vSeparatorHeight)
    }
    
    func configureTableView() {
        tvCurrency.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseIdentifire)
        tvCurrency.dataSource = self
        tvCurrency.delegate = self
        tvCurrency.rowHeight = Constants.rowHeight
        tvCurrency.separatorStyle = .none
        vContent.addSubview(tvCurrency)
        tvCurrency.anchor(leading: vContent.leadingAnchor,
                          top: vSearch.bottomAnchor,
                          trailing: vContent.trailingAnchor,
                          bottom: vContent.bottomAnchor,
                          paddingLeading: Constants.tvPadding,
                          paddingTop: Constants.tvPadding,
                          paddingTrailing: -Constants.tvPadding)
        tvCurrency.backgroundColor = .white
    }
}

// MARK: - Public API

extension BaseViewController {
    func hideSearch() {
        vSearch.isHidden = true
        vSearchHeightConstraint?.constant = 0
    }
}

// MARK: - UITableViewDataSource

extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BaseViewController: UITableViewDelegate {
    
}

// MARK: - UITextFieldDelegate

extension BaseViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {        
        
        return true
    }
}
