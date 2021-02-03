//
//  SignUp.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI

struct SignUp: View {
    @State var email = ""
    @State var password = ""
    @State var repassword = ""

    @State var color = Color.black.opacity(0.7)

    @State var visible = false
    @State var revisible = false

    @State var alert = false
    @State var error = ""

    let borderColor = Color(red: 107.0 / 255.0, green: 164.0 / 255.0, blue: 252.0 / 255.0)
    var authVM = AuthVM()
    var body: some View {
        VStack {
            Image("loginBG").resizable().frame(width: 300.0, height: 255.0, alignment: .center)

            Text("Sign up a new account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.color)
                .padding(.top, 15)

            TextField("Username or Email", text: self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).stroke(self.borderColor, lineWidth: 2))
                .padding(.top, 0)

            HStack(spacing: 15) {
                VStack {
                    if self.visible {
                        TextField("Password", text: self.$password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: self.$password)
                            .autocapitalization(.none)
                    }
                }

                Button(action: {
                    self.visible.toggle()
                        }) {
                    // Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .stroke(self.borderColor, lineWidth: 2))
            .padding(.top, 10)

            // Confirm password
            HStack(spacing: 15) {
                VStack {
                    if self.revisible {
                        TextField("Confirm Password", text: $repassword)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Confirm Password", text: $repassword)
                            .autocapitalization(.none)
                    }
                }

                Button(action: {
                    self.revisible.toggle()
                        }) {
                    // Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .stroke(self.borderColor, lineWidth: 2))
            .padding(.top, 10)

            // Sign up button
            Button(action: {
                self.Register()
                    }) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(borderColor)
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: self.$alert) { () -> Alert in
                Alert(title: Text("Sign up error"), message: Text("\(self.error)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
        }
        .padding(.horizontal, 25)
    }

    func Register() {
        if email != "" {
            if password == repassword {
                authVM.signUpUser(email, password, onCompletion: { (_, errorObj) -> Void in
                    if let _ = errorObj {
                        self.error = errorObj!.localizedDescription
                        self.alert.toggle()
                        return
                    } else {
                        UserDefaults.standard.set(true, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
                        NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)
                    }

                })
            } else {
                error = "Password mismatch"
                alert.toggle()
            }
        } else {
            error = "Please fill all the contents properly"
            alert.toggle()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
