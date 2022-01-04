//
//  AttendViewModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

protocol AttendDelegate {
    func onSuccess()
    func onFail()
}

class AttendViewModel {
    var attends: [AttendData] = []
    var delegate: AttendDelegate?
    let defaults = UserDefaults()
    
    func getAttend() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "finance.brighton.co.id"
        urlComponents.path = "/absensi-api/absenlog"
        urlComponents.queryItems = [
            URLQueryItem(name: "Start", value: "0"),
            URLQueryItem(name: "AccessToken", value: defaults.string(forKey: "Access Token")),
            URLQueryItem(name: "Count", value: "10"),
            URLQueryItem(name: "ClientID", value: LoginViewModel().clientID)
        ]
        
        let url = urlComponents.url
        
        let urlSession = URLSession.shared.dataTask(with: url!) { data, respone, error in
            if let error = error {
                self.delegate?.onFail()
                print("Cannot get Attends, Error: \(error.localizedDescription)")
            } else {
                guard let data = data else { return }
                let decode = try? JSONDecoder().decode(Respone.self, from: data)
                let code = decode?.Message.Code
                
                if code == 200 {
                    let decode = try? JSONDecoder().decode(Attend.self, from: data)
                    DispatchQueue.main.async {
                        self.attends = decode?.Data ?? []
                        self.delegate?.onSuccess()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.onFail()
                    }
                }
                
            }
        }
        
        urlSession.resume()
    }
    
    func getDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MM yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
}
