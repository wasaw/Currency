//
//  ChangeAlertViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let cornerRadius: CGFloat = 25.0
    static let vAlertWidth: CGFloat = 252.0
    static let vAlertHeight: CGFloat = 291.0
    static let smallPadding: CGFloat = 12.0
    static let lblPricePaddingTop: CGFloat = 25.0
    static let tfPricePaddingTop: CGFloat = 15.0
    static let vSeparatorPaddingTop: CGFloat = 8.0
    static let vSeparatorWidth: CGFloat = 160.0
    static let vSeparatorHeight: CGFloat = 1.0
    static let btnCornerRadius: CGFloat = 20.0
    static let btnPadding: CGFloat = 25.0
    static let btnPaddingTop: CGFloat = 10.0
    static let btnWidth: CGFloat = 92.0
    static let btnHeight: CGFloat = 42.0
}

final class ChangeAlertViewController: UIViewController {
    
// MARK: - Properties
    
    private let currency: AlertPreview
    
    private lazy var vAlert: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .white
        return view
    }()
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Change Alert"
        lbl.font = UIFont(name: "MulishRoman-Medium", size: 20)
        lbl.textAlignment = .center
        lbl.textColor = .titleColor
        return lbl
    }()
    private lazy var lblPrice: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "MulishRoman-Medium", size: 25)
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    private lazy var tfPrice: UITextField = {
        let tf = UITextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholderColor,
            .font: UIFont(name: "MulishRoman-Medium", size: 20) ?? UIFont.systemFont(ofSize: 20)
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "type price", attributes: placeholderAttributes)
        tf.font = UIFont(name: "MulishRoman-Medium", size: 25) ?? UIFont.systemFont(ofSize: 25)
        tf.textAlignment = .center
        tf.textColor = .black
        return tf
    }()
    private lazy var vSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private lazy var btnDelete: UIButton = {
        let btn = UIButton()
        
        let lbl = UILabel()
        lbl.text = "Delete"
        lbl.textColor = .white
        lbl.font =  UIFont(name: "MulishRoman-Medium", size: 15)
        btn.addSubview(lbl)
        lbl.centerX(inView: btn)
        lbl.centerY(inView: btn)
        
        btn.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        btn.layer.cornerRadius = Constants.btnCornerRadius
        btn.backgroundColor = .btnDeleteColor
        return btn
    }()
    private lazy var btnOk: UIButton = {
        let btn = UIButton()
        
        let lbl = UILabel()
        lbl.text = "Ok"
        lbl.textColor = .white
        lbl.font =  UIFont(name: "MulishRoman-Medium", size: 15)
        btn.addSubview(lbl)
        lbl.centerX(inView: btn)
        lbl.centerY(inView: btn)
        
        btn.addTarget(self, action: #selector(handleOk), for: .touchUpInside)
        btn.layer.cornerRadius = Constants.btnCornerRadius
        btn.backgroundColor = .btnBackgroundColor
        return btn
    }()
    private lazy var btnCancel: UIButton = {
        let btn = UIButton()
        
        let lbl = UILabel()
        lbl.text = "Cancel"
        lbl.textColor = .white
        lbl.font =  UIFont(name: "MulishRoman-Medium", size: 15)
        btn.addSubview(lbl)
        lbl.centerX(inView: btn)
        lbl.centerY(inView: btn)
        
        btn.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        btn.layer.cornerRadius = Constants.btnCornerRadius
        btn.backgroundColor = .black
        return btn
    }()
    
// MARK: - Lifecycle
    
    init(currency: AlertPreview) {
        self.currency = currency
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Private API

private extension ChangeAlertViewController {
    func configureUI() {
        view.addSubview(vAlert)
        vAlert.centerX(inView: view)
        vAlert.centerY(inView: view)
        vAlert.anchor(width: Constants.vAlertWidth, height: Constants.vAlertHeight)
        
        vAlert.addSubview(lblTitle)
        lblTitle.centerX(inView: vAlert)
        lblTitle.anchor(leading: vAlert.leadingAnchor,
                        top: vAlert.topAnchor,
                        trailing: vAlert.trailingAnchor,
                        paddingLeading: Constants.smallPadding,
                        paddingTop: Constants.smallPadding,
                        paddingTrailing: -Constants.smallPadding)
        
        vAlert.addSubview(lblPrice)
        lblPrice.centerX(inView: vAlert)
        lblPrice.anchor(leading: vAlert.leadingAnchor,
                        top: lblTitle.bottomAnchor,
                        trailing: vAlert.trailingAnchor,
                        paddingLeading: Constants.smallPadding,
                        paddingTop: Constants.lblPricePaddingTop,
                        paddingTrailing: -Constants.smallPadding)
        
        vAlert.addSubview(tfPrice)
        tfPrice.centerX(inView: vAlert)
        tfPrice.anchor(leading: vAlert.leadingAnchor,
                       top: lblPrice.bottomAnchor,
                       trailing: vAlert.trailingAnchor,
                       paddingLeading: Constants.smallPadding,
                       paddingTop: Constants.tfPricePaddingTop,
                       paddingTrailing: -Constants.smallPadding)
        
        vAlert.addSubview(vSeparator)
        vSeparator.centerX(inView: vAlert)
        vSeparator.anchor(top: tfPrice.bottomAnchor,
                          paddingTop: Constants.vSeparatorPaddingTop,
                          width: Constants.vSeparatorWidth,
                          height: Constants.vSeparatorHeight)
        
        vAlert.addSubview(btnDelete)
        btnDelete.anchor(leading: vAlert.leadingAnchor,
                         top: vSeparator.bottomAnchor,
                         paddingLeading: Constants.btnPadding,
                         paddingTop: Constants.btnPadding,
                         width: Constants.btnWidth,
                         height: Constants.btnHeight)
        
        vAlert.addSubview(btnOk)
        btnOk.anchor(top: vSeparator.bottomAnchor,
                     trailing: vAlert.trailingAnchor,
                     paddingTop: Constants.btnPadding,
                     paddingTrailing: -Constants.btnPadding,
                     width: Constants.btnWidth,
                     height: Constants.btnHeight)
        
        vAlert.addSubview(btnCancel)
        btnCancel.anchor(leading: btnDelete.leadingAnchor,
                         top: btnDelete.bottomAnchor,
                         trailing: btnOk.trailingAnchor,
                         paddingTop: Constants.btnPaddingTop,
                         height: Constants.btnHeight)
        
        lblPrice.text = currency.price
        view.backgroundColor = .black.withAlphaComponent(0.5)

        tfPrice.text = "$" + currency.alert
        tfPrice.textColor = currency.isPositiveAlert ? .revenueColor : .red
    }
    
// MARK: - Selectors
    
    @objc func handleOk() {
        CurrencyService.shared.updateAlert(text: tfPrice.text, for: currency)
        dismiss(animated: true)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDelete() {
        CoreDataService.shared.deleteAlert(id: currency.id)
        dismiss(animated: true)
    }
}
