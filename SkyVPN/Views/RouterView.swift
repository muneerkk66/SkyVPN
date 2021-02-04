//
//  RootView.swift
//  SkyVPN
//
//  Created by x218507 on 04/02/21.
//

import SwiftUI

struct RouterView: View {
    @State var status = UserDefaults.standard.value(forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue) as? Bool ?? false

    var body: some View {

        VStack {
            if self.status {
                Home()

            } else {
                VStack {
                    Login()
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil, queue: .main) { _ in

                        self.status = UserDefaults.standard.value(forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue) as? Bool ?? false
                    }
                }
            }
        }
    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
    }
}
