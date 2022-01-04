//
//  BaseViewController.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import UIKit

class BaseViewController: UIViewController {
    var spinnerContainer: UIView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showParentSpinner() {
        guard self.parent != nil else{return}
        showSpinner(view:(self.parent?.view)!)
    }
    
    func showSpinner(view:UIView) {
        let screenSize = UIScreen.main.bounds
        if spinnerContainer == nil {
            spinnerContainer = UIView()
            spinnerContainer.frame = CGRect(x: view.center.x, y: view.center.y - 75, width: screenSize.width, height: screenSize.height + 90)
            spinnerContainer.center = view.center
            spinnerContainer.backgroundColor = UIColor.black
            spinnerContainer.alpha = 0.7
        }
        
        activityIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
        activityIndicator.center = CGPoint(x:spinnerContainer.frame.size.width / 2, y:spinnerContainer.frame.size.height / 2);
        spinnerContainer.addSubview(activityIndicator)
        var rotationAnimation: CABasicAnimation?
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationAnimation?.toValue = .pi * 2.0
        rotationAnimation?.duration = 1.5
        rotationAnimation?.isCumulative = true
        rotationAnimation?.repeatCount = MAXFLOAT
        view.addSubview(spinnerContainer)
        activityIndicator.startAnimating()
    }
    
    func removeSpinner() {
        activityIndicator.stopAnimating()
        if spinnerContainer != nil {
            spinnerContainer.removeFromSuperview()
        }
    }
}
