//
//  AppConstants.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
import UIKit

class SkyVPNConstants: NSObject {
    // MARK: - URL & API details

    enum BaseURL: String {
        case production = "https://getskybox.app"
        // case test             = "http://getskybox.app
    }

    enum APIUrls: String {
        case signUp = "/api/v1/user/"
        case auth = "/api/auth/"
    }

    enum URLKeys: String {
        case sessionID
        case identity
        case username
        case password
        case email
    }

    // MARK: - Pointed Server

    static let baseURL = BaseURL.production.rawValue

    enum UserDefaultKeys: String {
        case sessionToken = "token"
        case userStatus
    }
}
