//
//  Home.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI

struct Home: View {
    @State var status = UserDefaults.standard.value(forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue) as? Bool ?? false

    var body: some View {
        VStack {
            if self.status {
                HomeScreen()

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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct HomeScreen: View {
    var body: some View {
        VStack {
            Image("loginBG").resizable().frame(width: 300.0, height: 225.0, alignment: .center)

            Text("Signed in successfully")
                .font(.title)
                .fontWeight(.bold)

            Button(action: {
                // try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)

            }) {
                Text("Sign out")
                    .foregroundColor(Color(.white))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color(UIColor.appColor()))
            .cornerRadius(4)
            .padding(.top, 25)
        }
    }
}
