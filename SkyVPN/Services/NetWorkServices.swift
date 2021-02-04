//
//  NetWorkServices.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Alamofire
import UIKit

private typealias APICalls = NetworkService

class NetworkService: NSObject {
    var baseURL = SkyVPNConstants.baseURL
    internal typealias ApiCompletionBlock = (_ responseObject: AnyObject?, _ errorObject: NSError?) -> Void

    // MARK: - Enum to handle invalid status codes

    enum StatusCode: Int {
        case invalidSession = 403
        case olderAppVersion = 405
        case serviceUnavailable = 503
        case notAvailable = 470
    }

    // MARK: - Validate the status code

    fileprivate func validateStatusCode(with statusCode: Int? = nil) -> Bool {
        if let status = statusCode {
            if status == StatusCode.invalidSession.rawValue || status == StatusCode.olderAppVersion.rawValue || status == StatusCode.serviceUnavailable.rawValue || status == StatusCode.notAvailable.rawValue {
                return false
            }
        }
        return true
    }

    //MARK:- Method to return the request header
    

    fileprivate func requestHeader() -> [String: String] {
        var headers = [String: String]()

        if let sessionID = UserDefaults.standard.value(forKey: SkyVPNConstants.UserDefaultKeys.sessionToken.rawValue) {
            headers[SkyVPNConstants.URLKeys.sessionID.rawValue] = sessionID as? String
        }

        return headers
    }
}

extension APICalls {
    // MARK: - Makes a DELETE Request

    /**
     - Parameter url: The url to fetch the data
     - Parameter parameters: The JSON data that has to be sent
     - Parameter completionBlock: Block that says whether the request was successful or failure

     */
    public func deleteRequest(_ url: String, parameters: [String: AnyObject]?, completionBlock: @escaping ApiCompletionBlock) {
        Alamofire.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { [weak self] (response) -> Void in

                guard let weakSelf = self else {
                    return
                }

                if let statusCode = response.response?.statusCode {
                    if weakSelf.validateStatusCode(with: statusCode) == true {
                        switch response.result {
                        case .success:
                            /* to check versonError in result*/
                            completionBlock(response.data as AnyObject?, nil)
                        case let .failure(error):
                            completionBlock(nil, error as NSError?)
                        }
                    } else {
                        // Show Error Alert
                    }
                } else {
                    completionBlock(nil, response.error as NSError?)
                }
            }
    }

    // MARK: Makes a POST Request

    /*
     - Parameter url: The url to post data
     - Parameter parameters: The JSON data that has to be sent
     - Parameter completionBlock: Block that says whether the request was successful or failure

     */

    public func postRequestPath(_ url: String, parameters: [String: AnyObject]?, completionBlock: @escaping ApiCompletionBlock) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: requestHeader()).responseJSON { [weak self] (response) -> Void in

            guard let weakSelf = self else {
                return
            }
            if let statusCode = response.response?.statusCode {
                if weakSelf.validateStatusCode(with: statusCode) == true {
                    switch response.result {
                    case .success:
                        /* to check versonError in result*/
                        completionBlock(response.data as AnyObject?, nil)
                    case let .failure(error):
                        completionBlock(nil, error as NSError?)
                    }
                } else {
                    // Show Error Alert
                }
            } else {
                completionBlock(nil, response.error as NSError?)
            }
        }
    }
}
