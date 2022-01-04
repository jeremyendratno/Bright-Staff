//
//  MainMenuViewModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

protocol LogoutDelegate {
    func onSuccessLogout()
    func onFailLogout()
}

class MainMenuViewModel {
    var delegate: LogoutDelegate?
    var defaults = UserDefaults()
    
    func logout() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "finance.brighton.co.id"
        urlComponents.path = "/user-api/logout"
        urlComponents.queryItems = [
            URLQueryItem(name: "ClientID", value: LoginViewModel().clientID),
            URLQueryItem(name: "AccessToken", value: defaults.string(forKey: "Access Token"))
        ]
        
        let url = urlComponents.url
        
        let urlSession = URLSession.shared.dataTask(with: url!) { data, respone, error in
            if let error = error {
                print("Failed to Logout, Error: \(error.localizedDescription)")
                self.delegate?.onFailLogout()
            } else {
                let decode = try? JSONDecoder().decode(Respone.self, from: data!)
                let code = decode?.Message.Code
                
                if code == 200 {
                    DispatchQueue.main.async {
                        self.delegate?.onSuccessLogout()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.onFailLogout()
                    }
                }
            }
        }
        
        urlSession.resume()
    }
    
    func saveToUserDefault() {
        defaults.set(false, forKey: "isLogin")
        defaults.set("", forKey: "Access Token")
    }
}
