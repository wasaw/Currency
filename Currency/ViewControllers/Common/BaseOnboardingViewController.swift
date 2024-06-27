//
//  BaseOnboardingViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let lblPaddingTop: CGFloat = 45.0
    static let horizontalPadding: CGFloat = 35.0
    static let ivPaddingTop: CGFloat = 60.0
//    static let ivWidth: CGFloat = 290.0
    static let ivHeight: CGFloat = 297.0
    static let descriptionPaddingTop: CGFloat = 35.0
    static let btnPaddingBottom: CGFloat = 70.0
    static let btnWidth: CGFloat = 167.0
    static let btnHeight: CGFloat = 46.0
}

class BaseOnboardingViewController: UIViewController {
    
// MARK: - Properties
    
    var txtTitle: String { "" }
    var txtImage: String { "" }
    var txtDescription: String { "" }
    var txtBtn: String { "" }
            
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = txtTitle
        lbl.font = UIFont(name: "MulishRoman-Medium", size: 27)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    private lazy var ivScreen: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: txtImage)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    lazy var lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.text = txtDescription
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textColor = .white
        return lbl
    }()
    private lazy var btnNext: UIButton = {
        let btn = UIButton()
        
        let lbl = UILabel()
        lbl.text = txtBtn
        lbl.textColor = .white
        lbl.font =  UIFont(name: "MulishRoman-Medium", size: 15)
        btn.addSubview(lbl)
        lbl.centerX(inView: btn)
        lbl.centerY(inView: btn)
        
        btn.layer.cornerRadius = 24.0
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        btn.backgroundColor = .btnBackgroundColor
        return btn
    }()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        configureUI()
    }
    
// MARK: - Selectors
    
    @objc func handleNext() {
    }
}

// MARK: - Private API

private extension BaseOnboardingViewController {
    func configureUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.backgroundStartGradient.cgColor, UIColor.backgroundEndGradient.cgColor]
        gradientLayer.locations = [0.0, 1.4, 1.7]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(lblTitle)
        lblTitle.centerX(inView: lblTitle)
        lblTitle.anchor(leading: view.leadingAnchor,
                        top: view.safeAreaLayoutGuide.topAnchor,
                        trailing: view.trailingAnchor,
                        paddingTop: Constants.lblPaddingTop)
        
        view.addSubview(ivScreen)
        ivScreen.anchor(leading: view.leadingAnchor,
                        top: lblTitle.bottomAnchor,
                        trailing: view.trailingAnchor,
                        paddingLeading: Constants.horizontalPadding,
                        paddingTop: Constants.ivPaddingTop,
                        paddingTrailing: -Constants.horizontalPadding,
                        height: Constants.ivHeight)
        
        view.addSubview(lblDescription)
        lblDescription.anchor(leading: view.leadingAnchor,
                              top: ivScreen.bottomAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: Constants.horizontalPadding,
                              paddingTop: Constants.descriptionPaddingTop,
                              paddingTrailing: -Constants.horizontalPadding)
        
        view.addSubview(btnNext)
        btnNext.centerX(inView: view)
        btnNext.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                       paddingBottom: -Constants.btnPaddingBottom,
                       width: Constants.btnWidth,
                       height: Constants.btnHeight)
    }
}
