//
//  LoadingViewController.swift
//  Currency
//
//

import UIKit

private enum Constants {
    static let ivPadding: CGFloat = 110.0
    static let ivLoadingPadding: CGFloat = 10.0
}

final class LoadingViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "loading"
        lbl.font = UIFont(name: "MulishRoman-Medium", size: 45)
        lbl.textAlignment = .center
        lbl.textColor = .white
        return lbl
    }()
    private lazy var ivLoading: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Loading")
        return iv
    }()
    private lazy var ivAnimate: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Animate")
        return iv
    }()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        animateImageView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: { [weak self] in
            self?.navigationController?.pushViewController(GetStartedViewController(), animated: true)
        })
    }
}

// MARK: - Private API

private extension LoadingViewController {
    func configureUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.backgroundStartGradient.cgColor, UIColor.backgroundEndGradient.cgColor]
        gradientLayer.locations = [0.0, 1.4, 1.7]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(lblTitle)
        lblTitle.centerX(inView: view)
        lblTitle.centerY(inView: view)
        
        view.addSubview(ivLoading)
        ivLoading.centerX(inView: view)
        ivLoading.centerY(inView: view, constant: -Constants.ivPadding)
        
        ivLoading.addSubview(ivAnimate)
        ivAnimate.anchor(trailing: ivLoading.trailingAnchor,
                         bottom: ivLoading.bottomAnchor,
                         paddingTrailing: Constants.ivLoadingPadding,
                         paddingBottom: Constants.ivLoadingPadding)
    }
    
    func animateImageView() {
        let squarePath = [
                    CGPoint(x: -5, y: -10),
                    CGPoint(x: 70, y: -10),
                    CGPoint(x: 70, y: 70),
                    CGPoint(x: -5, y: 70),
                    CGPoint(x: -5, y: -10)
                ]
           
        let path = UIBezierPath()
        path.move(to: squarePath[0])
        for point in squarePath.dropFirst() {
            path.addLine(to: point)
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 6.0 // Длительность анимации
        animation.fillMode = .forwards
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .linear)

        
        ivAnimate.layer.add(animation, forKey: "moveAlongSquarePath")
   }
}
