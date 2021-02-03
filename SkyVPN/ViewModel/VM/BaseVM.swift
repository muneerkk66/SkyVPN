//
//  BaseVM.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
class BaseVM: NSObject {
    // MARK: - Common completetionblock for VM classes

    internal typealias VMDataCompletionBlock = (_ responseObject: Any?, _ errorObject: NSError?) -> Void
    internal typealias VMCompletionBlock = (_ errorObject: Error?) -> Void
}
