//
//  SelectedCurrencyViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let radius: CGFloat = 32.58
    static let titlePadding: CGFloat = 20.0
    static let tvPadding: CGFloat = 20.0
    static let informationPadding: CGFloat = 10.0
    static let rowHeight: CGFloat = 74.0
    static let tvInformationCountRowHeight: CGFloat = 29.0
    static let separatorHeight: CGFloat = 1.0
    static let informationHeight: CGFloat = 400.0
    static let logoDimensions: CGFloat = 56.0
    static let likeDimensions: CGFloat = 25.0
    static let centerPadding: CGFloat = 10.0
    static let leadingPadding: CGFloat = 26.0
    static let trailingPadding: CGFloat = 10.0
    static let paddingTop: CGFloat = 25.0
    static let tvCurrencyPaddingTop: CGFloat = 5.0
    static let tvInformationHeight: CGFloat = 162.0
    static let btnVerticalPadding: CGFloat = 29.0
    static let btnWidth: CGFloat = 160.0
    static let btnHeight: CGFloat = 45.0
    static let tvInformationCount: Int = 5
}

final class SelectedCurrencyViewController: UIViewController {
    
// MARK: - Properties
    
    private let exchangeRate: [Currency]
    private let selectedIndex: Int
    
    private var titleName: String { "Cryptocurrency" }
    
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
    
    lazy var tvCurrency = UITableView(frame: .zero)
    lazy var tvInformation = UITableView(frame: .zero)
    
    private lazy var vInformation: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var ivLogo: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    private lazy var lblTitleCurrency: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MulishRoman-Medium", size: 18)
        label.textColor = .black
        return label
    }()
    private lazy var lblShortTitle: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = UIFont(name: "MulishRoman-Medium", size: 14)
        label.textColor = .shortCurrencyColor
        return label
    }()
    private lazy var ivLike: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Like")
//        iv.addGestureRecognizer(tgHandleLike)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    private lazy var lblPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MulishRoman-Medium", size: 34)
        label.textColor = .black
        return label
    }()
    private lazy var btnAlert: UIButton = {
        let btn = UIButton()
        
        let lbl = UILabel()
        lbl.text = "Add Alert"
        lbl.textColor = .white
        lbl.font =  UIFont(name: "MulishRoman-Medium", size: 15)
        btn.addSubview(lbl)
        lbl.centerX(inView: btn)
        lbl.centerY(inView: btn)
        
        btn.layer.cornerRadius = 24.0
        btn.backgroundColor = .btnBackgroundColor
        return btn
    }()
    private lazy var vSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorCellColor
        return view
    }()
    
// MARK: - Lifecycle
    
    init(exchangeRate: [Currency], selectedIndex: Int) {
        self.exchangeRate = exchangeRate
        self.selectedIndex = selectedIndex
                
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.backgroundStartGradient.cgColor, UIColor.backgroundEndGradient.cgColor]
        gradientLayer.locations = [0.0, 1.4, 1.7]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        configure(exchangeRate[selectedIndex])
        configureUI()
    }
}

// MARK: Private API

private extension SelectedCurrencyViewController {
    func configure(_ currency: Currency) {
        ivLogo.image = UIImage(named: currency.title)
        lblTitleCurrency.text = currency.title
        lblPrice.text = currency.price
    }
    
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
        
        view.addSubview(vInformation)
        vInformation.anchor(leading: view.leadingAnchor,
                            top: lblTitle.bottomAnchor,
                            trailing: view.trailingAnchor,
                            paddingLeading: Constants.tvPadding,
                            paddingTop: Constants.titlePadding,
                            paddingTrailing: -Constants.tvPadding,
                            height: Constants.informationHeight)
        
        configureInformationView()
        configureTableView()
        configureBtn()
    }
    
    func configureInformationView() {
        vInformation.addSubview(ivLogo)
        ivLogo.anchor(leading: vInformation.leadingAnchor,
                      top: vInformation.topAnchor,
                      paddingLeading: Constants.informationPadding,
                      width: Constants.logoDimensions,
                      height: Constants.logoDimensions)
        
        vInformation.addSubview(ivLike)
        ivLike.centerY(inView: ivLogo)
        ivLike.anchor(trailing: vInformation.trailingAnchor,
                      paddingTrailing: -Constants.informationPadding,
                      width: Constants.likeDimensions,
                      height: Constants.likeDimensions)
        
        vInformation.addSubview(lblTitleCurrency)
        lblTitleCurrency.centerY(inView: ivLogo, constant: -Constants.centerPadding)
        lblTitleCurrency.anchor(leading: ivLogo.trailingAnchor,
                                trailing: ivLike.trailingAnchor,
                                paddingLeading: Constants.leadingPadding,
                                paddingTrailing: -Constants.trailingPadding)
        
        vInformation.addSubview(lblShortTitle)
        lblShortTitle.centerY(inView: ivLogo, constant: Constants.centerPadding)
        lblShortTitle.anchor(leading: ivLogo.trailingAnchor, 
                             trailing: ivLike.trailingAnchor,
                             paddingLeading: Constants.leadingPadding,
                             paddingTrailing: -Constants.trailingPadding)
        
        vInformation.addSubview(lblPrice)
        lblPrice.anchor(leading: vInformation.leadingAnchor,
                        top: lblShortTitle.bottomAnchor,
                        trailing: vInformation.trailingAnchor,
                        paddingLeading: Constants.informationPadding,
                        paddingTop: Constants.paddingTop)
    }
    
    func configureTableView() {
        tvCurrency.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.reuseIdentifire)
        tvCurrency.dataSource = self
        tvCurrency.delegate = self
        tvCurrency.separatorStyle = .none
        vContent.addSubview(tvCurrency)
        tvCurrency.anchor(leading: vContent.leadingAnchor,
                          top: vInformation.bottomAnchor,
                          trailing: vContent.trailingAnchor,
                          bottom: vContent.bottomAnchor,
                          paddingLeading: Constants.tvPadding,
                          paddingTop: Constants.tvCurrencyPaddingTop,
                          paddingTrailing: -Constants.tvPadding)
        tvCurrency.backgroundColor = .white
        
        tvInformation.register(InformationCell.self, forCellReuseIdentifier: InformationCell.reuseIdentifire)
        tvInformation.dataSource = self
        tvCurrency.delegate = self
        tvInformation.separatorStyle = .none
        vInformation.addSubview(tvInformation)
        tvInformation.anchor(leading: vInformation.leadingAnchor,
                          top: lblPrice.bottomAnchor,
                          trailing: vInformation.trailingAnchor,
                          paddingLeading: Constants.informationPadding,
                          paddingTop: Constants.tvPadding,
                          paddingTrailing: -Constants.informationPadding,
                          height: Constants.tvInformationHeight)
        tvInformation.backgroundColor = .white
    }
    
    func configureBtn() {
        vInformation.addSubview(btnAlert)
        btnAlert.centerX(inView: vInformation)
        btnAlert.anchor(top: tvInformation.bottomAnchor, 
                        paddingTop: Constants.btnVerticalPadding,
                        width: Constants.btnWidth,
                        height: Constants.btnHeight)
        
        vInformation.addSubview(vSeparator)
        vSeparator.anchor(leading: vInformation.leadingAnchor,
                          trailing: vInformation.trailingAnchor,
                          bottom: btnAlert.bottomAnchor,
                          paddingBottom: Constants.btnVerticalPadding,
                          height: Constants.separatorHeight)
    }
}

// MARK: - UITableViewDataSource

extension SelectedCurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tvInformation {
            return Constants.tvInformationCount
        }
        return exchangeRate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tvCurrency,
           let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reuseIdentifire, for: indexPath) as? CurrencyCell {
            cell.configure(for: .currency, value: exchangeRate[indexPath.row])
            
            return cell
        }
        
        if tableView == tvInformation,
           let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.reuseIdentifire, for: indexPath) as? InformationCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension SelectedCurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tvInformation {
            return Constants.tvInformationCountRowHeight
        }
        
        return Constants.rowHeight
    }
}
