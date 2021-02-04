//
//  AppExtension.swift
//  SkyVPN
//
//  Created by x218507 on 04/02/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    class func appColor() -> UIColor {
        return UIColor(red: 117.0 / 255.0, green: 96.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
    }
}

extension View {
    @ViewBuilder func show(_ show: Bool) -> some View {
        if show {
            self
        } else {
            self.hidden()
        }
    }
}
