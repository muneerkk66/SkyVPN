//
//  BaseAPIHandler.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation

class BaseAPIHandler: NSObject {
    // MARK: - Common completetionblock for API classes

    internal typealias ApiCompletionBlock = (_ responseObject: AnyObject?, _ errorObject: NSError?) -> Void
    internal var networkService: NetworkService = NetworkService()

    // MARK: - initializers

    override init() {}
}
