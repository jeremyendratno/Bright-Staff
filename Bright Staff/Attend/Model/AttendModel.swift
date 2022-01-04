//
//  AttendModel.swift
//  Bright Staff
//
//  Created by Jeremy Endratno on 1/4/22.
//

import Foundation

struct Attend: Decodable {
    var Message: Message
    var Data: [AttendData]
}

struct AttendData: Codable {
    var Name: String
//    var DateIn: String
//    var DateOut: String
    var DistanceInDesc: String
    var DistanceOutDesc: String
}
