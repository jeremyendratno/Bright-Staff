//
//  BaseModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

struct Respone: Decodable {
    var Message: Message
}

struct Message: Decodable {
    var Code: Int
    var Text: String
}
