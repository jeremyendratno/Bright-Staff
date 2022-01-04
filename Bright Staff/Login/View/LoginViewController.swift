//
//  LoginViewController.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/3/22.
//

import UIKit

class LoginViewController: BaseViewController, LoginDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    func viewSetup() {
        loginViewModel.loginDelegate = self
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginButton(_ sender: Any) {
        showParentSpinner()
        loginViewModel.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    func onSuccessLogin() {
        removeSpinner()
        pushToMainMenu()
    }
    
    func onFailLogin() {
        removeSpinner()
        failedAlert()
    }
    
    func pushToMainMenu() {
        let mainMenuViewController = MainMenuViewController()
        navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    func failedAlert() {
        let failedMessage = loginViewModel.loginMessage?.Text
        let failedAlert = UIAlertController(title: "Failed to Login", message: failedMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        failedAlert.addAction(okAction)
        self.present(failedAlert, animated: true)
    }
}
