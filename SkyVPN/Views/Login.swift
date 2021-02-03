//
//  Login.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""

    var authVM = AuthVM()

    var body: some View {
        VStack {
            Image("loginBG").resizable().frame(width: 300.0, height: 255.0, alignment: .top)

            Text("Sign in to your account")
                .font(.title)
                .fontWeight(.regular)
                .padding(.top, 15)

            TextField("Username or Email", text: self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 6).stroke(Color(UIColor.appColor()), lineWidth: 2))
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
                        .foregroundColor(self.color)
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .stroke(Color(UIColor.appColor()), lineWidth: 2))
            .padding(.top, 10)

            HStack {
                Spacer()
                Button(action: {
                    self.ResetPassword()
                    self.visible.toggle()
                }) {
                    Text("Forget Password")
                        .fontWeight(.medium)
                        .foregroundColor(Color(UIColor.appColor()))
                }.padding(.top, 10.0)
            }

            // Sign in button
            Button(action: {
                self.Verify()
            }) {
                Text("Sign in")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color(UIColor.appColor()))
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: $alert) { () -> Alert in
                Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }

            HStack(spacing: 5) {
                Text("Don't have an account ?")

                NavigationLink(destination: SignUp()) {
                    Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.appColor()))
                }

                Text("now").multilineTextAlignment(.leading)

            }.padding(.top, 25)
        }
        .padding(.horizontal, 25)
    }

    func Verify() {
        if email != "", password != "" {
            authVM.loginUser(email, password, onCompletion: { (_, errorObj) -> Void in
                if let _ = errorObj {
                    self.error = errorObj!.localizedDescription
                    self.title = "Login Error"
                    self.alert.toggle()
                    return
                }
                UserDefaults.standard.set(true, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)

            })

        } else {
            title = "Login Error"
            error = "Please fill all the content property"
            alert = true
        }
    }

    func ResetPassword() {
        if email != "" {
            authVM.forgotUserPassword(email, onCompletion: { (_, errorObj) -> Void in

                if let _ = errorObj {
                    self.error = "Error"
                    self.alert.toggle()
                    return
                }
                self.title = "Password Reset Sucessfully!"
                self.error = "A new password is sent to your email!"
                self.alert.toggle()
            })
        } else {
            error = "Email Id is empty"
            alert.toggle()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Login()
        }
    }
}
