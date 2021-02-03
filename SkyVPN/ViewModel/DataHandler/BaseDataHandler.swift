//
//  BaseDataHandler.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import Foundation
import UIKit

class BaseDataHandler: NSObject {
    // MARK: - Common completetionblock for DataHandler classes

    internal typealias DataHandlerCompletionBlock = (_ errorObject: NSError?) -> Void
}
