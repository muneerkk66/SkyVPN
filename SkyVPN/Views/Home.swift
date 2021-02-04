//
//  Home.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Home: View {
    public var authVM = AuthVM()
    
    @State fileprivate var showLoader = false
    @State fileprivate var alert = false
    @State fileprivate var alertTitle = ""
    @State fileprivate var alertMessage = ""
    
    public var body: some View {
        VStack {
            Image("background").resizable().frame(width: 300.0, height: 225.0, alignment: .center)

            Text("Signed in successfully")
                .font(.title)
                .fontWeight(.bold)

            Button(action: {
                showLoader = true
                authVM.logoutUser(onCompletion: { (_, errorObj) -> Void in
                    showLoader = false
                    if let _ = errorObj {
                        self.alertTitle = SkyVPNConstants.Message.generalError.rawValue
                        self.alert.toggle()
                        return
                    }
                    self.alertMessage = SkyVPNConstants.Message.logout.rawValue
                    self.alertTitle = SkyVPNConstants.Message.success.rawValue
                    self.alert.toggle()
                })
                
                //MARK:- Remove all the data related to user
                authVM.removeUserDetails()
                

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
            .alert(isPresented: $alert) { () -> Alert in
                Alert(title: Text("\(self.alertTitle)"), message: Text("\(self.alertMessage)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
        }
    }
}


