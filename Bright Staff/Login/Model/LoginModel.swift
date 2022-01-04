//
//  LoginModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

struct Login: Decodable {
    var Message: Message
    var Data: LoginData
    var AccessToken: String
}

struct LoginData: Decodable {
    var Name: String
}
