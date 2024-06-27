//
//  CurrencyCell.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let ivDimensions: CGFloat = 51.63
    static let lblVerticalPadding: CGFloat = 12.0
    static let lblHorizontalPadding: CGFloat = 25.0
    static let lblShortHorizontalPadding: CGFloat = 12.0
    static let separatorHeight: CGFloat = 1.0
    static let additionalPadding: CGFloat = 12.0
}

final class CurrencyCell: UITableViewCell {
    static let reuseIdentifire = "CurrencyCell"
    
// MARK: - Properties
    
    private let coreData = CoreDataService.shared
    
    private lazy var ivLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Cell")
        iv.anchor(width: Constants.ivDimensions, height: Constants.ivDimensions)
        return iv
    }()
    
    private lazy var lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.font = UIFont(name: "MulishRoman-Medium", size: 18)
        label.textColor = .black
        return label
    }()
    
    private lazy var lblPrice: UILabel = {
        let label = UILabel()
        label.text = "$49,949.20"
        label.font = UIFont(name: "MulishRoman-Medium", size: 12)
        label.textColor = .priceColor
        return label
    }()
    
    private lazy var lblShortTitle: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = UIFont(name: "MulishRoman-Medium", size: 14)
        label.textColor = .shortCurrencyColor
        return label
    }()
    
    private lazy var lblAdditional: UILabel = {
        let label = UILabel()
        label.text = "-1.23%"
        label.font = UIFont(name: "MulishRoman-Medium", size: 16)
        label.textColor = .red
        return label
    }()
    
    private lazy var tgHandleLike = UITapGestureRecognizer(target: self, action: #selector(handleLike))
    private lazy var isFavourite = false
    
    private lazy var ivLike: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Like")
        iv.addGestureRecognizer(tgHandleLike)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var vSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorCellColor
        return view
    }()
    
// MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bringSubviewToFront(vSeparator)
    }
}

// MARK: - Private API

private extension CurrencyCell {
    
// MARK: - Helpers
    
    func configureUI() {
        contentView.addSubview(ivLogo)
        ivLogo.centerY(inView: contentView)
        ivLogo.anchor(leading: contentView.leadingAnchor)
        
        contentView.addSubview(lblTitle)
        lblTitle.centerY(inView: contentView, constant: -Constants.lblVerticalPadding)
        lblTitle.anchor(leading: ivLogo.trailingAnchor, paddingLeading: Constants.lblHorizontalPadding)
        
        contentView.addSubview(lblPrice)
        lblPrice.centerY(inView: contentView, constant: Constants.lblVerticalPadding)
        lblPrice.anchor(leading: ivLogo.trailingAnchor, paddingLeading: Constants.lblHorizontalPadding)
        
        contentView.addSubview(lblShortTitle)
        lblShortTitle.centerY(inView: contentView, constant: -Constants.lblVerticalPadding)
        lblShortTitle.anchor(leading: lblTitle.trailingAnchor, paddingLeading: Constants.lblShortHorizontalPadding)
        
        contentView.addSubview(lblAdditional)
        lblAdditional.centerY(inView: contentView)
        lblAdditional.anchor(trailing: contentView.trailingAnchor, paddingTrailing: -Constants.additionalPadding)
        lblAdditional.isHidden = true
        
        contentView.addSubview(ivLike)
        ivLike.centerY(inView: contentView)
        ivLike.anchor(trailing: contentView.trailingAnchor, paddingTrailing: -Constants.additionalPadding)
        ivLike.isHidden = true
        
        contentView.addSubview(vSeparator)
        vSeparator.anchor(leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          bottom: contentView.bottomAnchor,
                          height: Constants.separatorHeight)

        contentView.backgroundColor = .white
    }
    
// MARK: - Selectors
    
    @objc func handleLike() {
        isFavourite.toggle()
        ivLike.image = isFavourite ? UIImage(named: "LikeFull") : UIImage(named: "Like")
        guard let title = lblTitle.text else { return }
        CoreDataService.shared.updateIsFavourite(title: title)
    }
}


// MARK: - Open API

extension CurrencyCell {
    func configure(for type: CellType, value: CurrencyPreview? = nil) {
        switch type {
        case .currency:
            lblAdditional.isHidden = false
        case .favourite:
            ivLike.isHidden = false
        case .alert:
            lblAdditional.isHidden = false
        }
        
        guard let value = value else { return }
        lblTitle.text = value.title
        lblShortTitle.text = value.shortTitle
        lblPrice.text = value.price
        ivLogo.image = UIImage(named: value.title)
        lblAdditional.text = value.difference
        lblAdditional.textColor = value.isRevenue ? .revenueColor : .red
        if value.isFavourite {
            ivLike.image = UIImage(named: "LikeFull")
            isFavourite.toggle()
        }
        
        guard let isPositiveAlert = value.isPositiveAlert,
              let value = value.alert else { return }
        lblAdditional.textColor = isPositiveAlert ? .revenueColor : .red
        lblAdditional.text = "$" + value
    }
    
    func configure(for type: CellType, value: AlertPreview? = nil) {
        switch type {
        case .currency:
            lblAdditional.isHidden = false
        case .favourite:
            ivLike.isHidden = false
        case .alert:
            lblAdditional.isHidden = false
        }
        
        guard let value = value else { return }
        lblTitle.text = value.title
        lblShortTitle.text = value.shortTitle
        lblPrice.text = value.price
        ivLogo.image = UIImage(named: value.title)

        lblAdditional.textColor = value.isPositiveAlert ? .revenueColor : .red
        lblAdditional.text = "$" + value.alert
    }
}
