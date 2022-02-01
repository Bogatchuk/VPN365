//
//  UserModel.swift
//  SafariView+vpn
//
//  Created by MPro3.1 on 21.01.2022.
//

import Foundation

struct UserModel: Codable {
    let ip: String
    let user_name: String
    let password: String
    let l2tpPSK: String
}
