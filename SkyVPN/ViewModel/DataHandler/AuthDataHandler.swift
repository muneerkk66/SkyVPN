//
//  AuthDataHandler.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
import SwiftKeychainWrapper
class AuthDataHandler: BaseDataHandler {
    public func saveToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: SkyVPNConstants.UserDefaultKeys.sessionToken.rawValue)
    }
}
