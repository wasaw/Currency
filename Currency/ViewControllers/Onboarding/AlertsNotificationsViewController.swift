//
//  AlertsNotificationsViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let lblPaddingBottom: CGFloat = 20.0
}

final class AlertsNotificationsViewController: BaseOnboardingViewController {
    override var txtTitle: String { "Alerts notifications" }
    override var txtImage: String { "Alert" }
    override var txtDescription: String { "Add alerts for the cryptocurrencies you are actively monitoring and always stay informed about the ideal entry points." }
    override var txtBtn: String { "Get Started" }
    
    private lazy var lblPolicy: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MulishRoman-Medium", size: 16)
        label.textAlignment = .center
        let attributedString = NSAttributedString(string: "Privacy Policy", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.attributedText = attributedString
        label.textColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLbl))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(lblPolicy)
        lblPolicy.centerX(inView: view)
        lblPolicy.anchor(leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         paddingBottom: -Constants.lblPaddingBottom)
    }
    
    override func handleNext() {
        navigationController?.dismiss(animated: true)
                
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = TabBarContoller()
            window.makeKeyAndVisible()
        }
    }
}

// MARK: - Private API

private extension AlertsNotificationsViewController {
// MARK: - Selectors
    
    @objc func handleLbl() {
        present(PrivacyPolicyViewController(), animated: true)
    }
}
