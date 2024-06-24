//
//  PrivacyPolicyViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let radius: CGFloat = 32.58
    static let titlePadding: CGFloat = 20.0
    static let tvPadding: CGFloat = 10.0
    static let rowHeight: CGFloat = 74.0
    static let policyPaddingTop: CGFloat = 15.0
}

final class PrivacyPolicyViewController: UIViewController {
    
// MARK: - Properties
    
    var titleName: String { "Privacy Policy" }
    
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
    
    private lazy var vPolicy: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var tvPolicy: UITextView = {
        let tv = UITextView()
        tv.font = UIFont(name: "MulishRoman-Medium", size: 14)
        tv.text = """
        Lorem ipsum dolor sit amet consectetur. Leo in mauris quis id amet eu porttitor. Et eget venenatis proin pulvinar consectetur mi. Luctus donec a neque ultrices quis vulputate vulputate.
        Ut cursus pellentesque dolor lacus. Risus faucibus eu eu neque tellus pulvinar sit molestie. Eget elementum curabitur adipiscing diam eget viverra convallis interdum. Interdum magna ridiculus in et adipiscing nec dolor.

        In dignissim eget gravida aliquam tincidunt viverra. Bibendum blandit ipsum mi pharetra vitae tortor pulvinar. Risus gravida vitae sed et consequat sodales eget rutrum. Enim suspendisse tellus ipsum enim dolor orci tempus feugiat. Venenatis faucibus erat laoreet nulla.
        Morbi praesent quam enim fusce nec.

        Faucibus tincidunt rhoncus tellus sit auctor volutpat. Aliquam est congue egestas at turpis lacus elit bibendum scelerisque. Imperdiet velit condimentum purus phasellus. Gravida facilisis sed morbi tempor tristique proin mauris lorem mattis. Vel nunc mauris tincidunt ac aenean vel. Mollis feugiat posuere arcu nam varius tortor mollis.

        Faucibus tincidunt rhoncus tellus sit auctor volutpat. Aliquam est congue egestas at turpis lacus elit bibendum scelerisque. Imperdiet velit condimentum purus phasellus. Gravida facilisis sed morbi tempor trist
        """
        tv.textColor = .policyTextColor
        tv.backgroundColor = .white
        return tv
    }()
            
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

private extension PrivacyPolicyViewController {
    func configureUI() {
        view.addSubview(vContent)
        vContent.anchor(leading: view.leadingAnchor,
                           top: view.safeAreaLayoutGuide.topAnchor,
                           trailing: view.trailingAnchor,
                           bottom: view.bottomAnchor)
        vContent.layer.cornerRadius = Constants.radius
        
        vContent.addSubview(lblTitle)
        lblTitle.centerX(inView: vContent)
        lblTitle.anchor(top: vContent.topAnchor, paddingTop: Constants.titlePadding, height: 50.0)
        
        vContent.addSubview(vPolicy)
        vPolicy.anchor(leading: vContent.leadingAnchor,
                                  top: lblTitle.bottomAnchor,
                                  trailing: vContent.trailingAnchor,
                                  bottom: vContent.bottomAnchor,
                                  paddingLeading: Constants.tvPadding,
                                  paddingTop: Constants.policyPaddingTop,
                                  paddingTrailing: -Constants.tvPadding)
        
        vPolicy.addSubview(tvPolicy)
        tvPolicy.anchor(leading: vPolicy.leadingAnchor,
                          top: vPolicy.topAnchor,
                          trailing: vPolicy.trailingAnchor,
                          bottom: vPolicy.bottomAnchor,
                          paddingLeading: Constants.tvPadding,
                          paddingTop: -Constants.tvPadding,
                          paddingTrailing: -Constants.tvPadding)
    }
}
