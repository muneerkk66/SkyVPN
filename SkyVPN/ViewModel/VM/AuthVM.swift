//
//  AuthVM.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
class AuthVM: BaseVM {
    var apiHandler: AuthAPIHandler = AuthAPIHandler()
    var dataHandler: AuthDataHandler = AuthDataHandler()

    // MARK: - Login User

    public func loginUser(_ username: String, _ password: String, onCompletion: @escaping VMDataCompletionBlock) {
        let requestParams = [SkyVPNConstants.URLKeys.identity.rawValue: username as AnyObject,
                             SkyVPNConstants.URLKeys.password.rawValue: password as AnyObject]

        apiHandler.loginUser(requestParams) { [weak self] (responseObject, errorObject) -> Void in
            guard let weakSelf = self else {
                return
            }
            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(nil, errorObject)
                }
                return
            }
            do {
                // MARK: - We have used Codable & Decodable for json encoding & decoding

                let loginRes = try JSONDecoder().decode(LoginResponse.self, from: response)

                // MARK: - Save token in KeyChain

                weakSelf.dataHandler.saveToken(loginRes.data.token)
                onCompletion(loginRes.data.token, nil)

            } catch {
                onCompletion(nil, error as NSError)
            }
        }
    }

    // MARK: - Forgot Password

    public func forgotUserPassword(_ email: String, onCompletion: @escaping VMDataCompletionBlock) {
        let requestParams = [SkyVPNConstants.URLKeys.email.rawValue: email as AnyObject]

        apiHandler.resetUserPassword(requestParams) { (responseObject, errorObject) -> Void in

            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(nil, errorObject)
                }
                return
            }
            onCompletion(response, nil)
        }
    }

    // MARK: - Sign Up
    public func signUpUser(_ email: String, _ password: String, onCompletion: @escaping VMDataCompletionBlock) {
        let requestParams = [SkyVPNConstants.URLKeys.email.rawValue: email as AnyObject,
                             SkyVPNConstants.URLKeys.username.rawValue: email as AnyObject,
                             SkyVPNConstants.URLKeys.password.rawValue: password as AnyObject]
        apiHandler.signUpUser(requestParams) { (responseObject, errorObject) -> Void in

            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(nil, errorObject)
                }
                return
            }
            do {
                // MARK: - We have used Codable & Decodable for json encoding & decoding

                let userObj = try JSONDecoder().decode(SignUpResponse.self, from: response)
                onCompletion(userObj, nil)

            } catch {
                onCompletion(nil, error as NSError)
            }
        }
    }
    
    // MARK: - Logout
    public func logoutUser(onCompletion: @escaping VMDataCompletionBlock) {
        
        apiHandler.logoutUser() { (responseObject, errorObject) -> Void in

            guard let response = responseObject as? Data else {
                DispatchQueue.main.async {
                    onCompletion(nil, errorObject)
                }
                return
            }
            onCompletion(response, nil)
        }
    }
    
    public func removeUserDetails() {
        UserDefaults.standard.set(false, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
        NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)
        
        //MARK:- Remove Saved token from Keychain
        dataHandler.removeToken()
    }
}
