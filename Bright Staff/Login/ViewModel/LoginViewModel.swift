//
//  LoginViewModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

protocol LoginDelegate {
    func onSuccessLogin()
    func onFailLogin()
}

class LoginViewModel {
    var loginDelegate: LoginDelegate?
    var loginData: LoginData?
    var loginMessage: Message?
    var clientID = "3a07959f6c34782510df33b19c465bd7"
    var accessToken: String?
    let defaults = UserDefaults.standard
    
    func login(username: String, password: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "finance.brighton.co.id"
        urlComponents.path = "/user-api/login"
        urlComponents.queryItems = [
            URLQueryItem(name: "ClientID", value: clientID),
            URLQueryItem(name: "Username", value: username),
            URLQueryItem(name: "Password", value: password)
        ]
        
        let url = urlComponents.url
        
        let urlSession = URLSession.shared.dataTask(with: url!) { [weak self] data, respone, error in
            if let error = error {
                print("Login Failed, Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.loginDelegate?.onFailLogin()
                }
            } else {
                guard let data = data else { return }
                let decode = try? JSONDecoder().decode(Respone.self, from: data)
                self?.loginMessage = decode?.Message
                
                if self?.loginMessage?.Code == 200 {
                    let decode = try? JSONDecoder().decode(Login.self, from: data)
                    self?.accessToken = decode?.AccessToken
                    self?.loginData = decode?.Data
                    
                    DispatchQueue.main.async {
                        self?.saveToUserDefault()
                        self?.loginDelegate?.onSuccessLogin()
                    }
                }
                
                if self?.loginMessage?.Code == 400 || decode?.Message.Code == 417 {
                    DispatchQueue.main.async {
                        self?.loginDelegate?.onFailLogin()
                    }
                }
            }
        }
        
        urlSession.resume()
    }
    
    func saveToUserDefault() {
        defaults.set(true, forKey: "isLogin")
        defaults.set(accessToken, forKey: "Access Token")
    }
}
