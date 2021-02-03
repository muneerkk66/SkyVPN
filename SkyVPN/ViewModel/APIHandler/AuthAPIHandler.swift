//
//  LoginAPIHandler.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
class AuthAPIHandler: BaseAPIHandler {
    // MARK: Login API

    public func loginUser(_ requestParams: [String: AnyObject]?, _ onCompletion: @escaping ApiCompletionBlock) {
        let components = URLComponents(string: networkService.baseURL + SkyVPNConstants.APIUrls.auth.rawValue)
        guard let urlpath = components?.string else {
            return
        }
        networkService.postRequestPath(urlpath, parameters: requestParams) { (responseObject, errorObject) -> Void in

            onCompletion(responseObject, errorObject)
        }
    }

    // MARK: Sign UP

    public func signUpUser(_ requestParams: [String: AnyObject], _ onCompletion: @escaping ApiCompletionBlock) {
        let components = URLComponents(string: networkService.baseURL + SkyVPNConstants.APIUrls.signUp.rawValue)
        guard let urlpath = components?.string else {
            return
        }
        networkService.postRequestPath(urlpath, parameters: requestParams) { (responseObject, errorObject) -> Void in

            onCompletion(responseObject, errorObject)
        }
    }

    // MARK: Logout

    public func logoutUser(_ onCompletion: @escaping ApiCompletionBlock) {
        let components = URLComponents(string: networkService.baseURL + SkyVPNConstants.APIUrls.auth.rawValue)
        guard let urlpath = components?.string else {
            return
        }
        networkService.deleteRequest(urlpath, parameters: nil) { (responseObject, errorObject) -> Void in

            onCompletion(responseObject, errorObject)
        }
    }

    // MARK: Reset Password

    public func resetUserPassword(_ requestParams: [String: AnyObject], _ onCompletion: @escaping ApiCompletionBlock) {
        let components = URLComponents(string: networkService.baseURL + SkyVPNConstants.APIUrls.auth.rawValue)
        guard let urlpath = components?.string else {
            return
        }
        networkService.postRequestPath(urlpath, parameters: requestParams) { (responseObject, errorObject) -> Void in

            onCompletion(responseObject, errorObject)
        }
    }
}
