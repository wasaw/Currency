//
//  InformationCell.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let separatorHeight: CGFloat = 1.0
}

final class InformationCell: UITableViewCell {
    static let reuseIdentifire = "InformationCell"
    
// MARK: - Properties
    
    private lazy var lblLeading: UILabel = {
        let label = UILabel()
        label.text = "-1.23%"
        label.font = UIFont(name: "MulishRoman-Medium", size: 18)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var lblTrailing: UILabel = {
        let label = UILabel()
        label.text = "-1.23%"
        label.font = UIFont(name: "MulishRoman-Medium", size: 16)
        label.textAlignment = .right
        label.textColor = .black
        return label
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

private extension InformationCell {
    func configureUI() {
        
        contentView.addSubview(lblLeading)
        lblLeading.centerY(inView: contentView)
        lblLeading.anchor(leading: contentView.leadingAnchor)
        
        contentView.addSubview(lblTrailing)
        lblTrailing.centerY(inView: contentView)
        lblTrailing.anchor(trailing: contentView.trailingAnchor)
        
        contentView.addSubview(vSeparator)
        vSeparator.anchor(leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          bottom: contentView.bottomAnchor,
                          height: Constants.separatorHeight)
        
        contentView.backgroundColor = .white
    }
}

// MARK: - Public API

extension InformationCell {
    func configure(leadingTitle: String, trailingTitle: String) {
        lblLeading.text = leadingTitle
        lblTrailing.text = trailingTitle
    }
}
