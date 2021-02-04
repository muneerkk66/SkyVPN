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
    // MARK: - Pointed Server
    static let baseURL = BaseURL.production.rawValue

    
    

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

    
    enum UserDefaultKeys: String {
        case sessionToken = "token"
        case userStatus
    }
    
    enum Message:String {
        case emptyInputError = "Please Enter all the content property"
        case emptyEmail = "Email Id is empty"
        case loginFailed = "Failed to login"
        case passwordReset  = "Password Reset Sucessfully!"
        case emailHasBeenSent = "A new password is sent to your email!"
        case passwordMissMatch = "Password mismatch"
        case generalError = "Something went wrong. Please try again after some time"
        case logout = "Succesfully logout"
        case success = "Success"
    }
}
