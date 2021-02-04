//
//  Login.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI
struct Login: View {
    public var authVM = AuthVM()
    
    @State fileprivate var email = ""
    @State fileprivate var password = ""
    @State fileprivate var color = Color.black.opacity(0.7)
    @State fileprivate var visible = false
    @State fileprivate var alert = false
    @State fileprivate var alertTitle = ""
    @State fileprivate var alertMessage = ""
    @State fileprivate var showLoader = false

    
    public var body: some View {
        
        //MARK:BaseView is for to support common features
        BaseView {
            VStack {
                
                Image("background").resizable().frame(width: 300.0, height: 255.0, alignment: .top)
                
                Text("Sign in to your account")
                    .font(.title)
                    .fontWeight(.regular)
                    .padding(.top, 15)

                //MARK:- EMail Field
                TextField("Email", text: self.$email)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 6).stroke(Color(UIColor.appColor()), lineWidth: 2))
                    .padding(.top, 0)

                //MARK:- Password Field
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
      
                //MARK:- Loader
                ProgressView().show(showLoader)
                
                //MARK:- Sign in button
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
                    Alert(title: Text("\(self.alertTitle)"), message: Text("\(self.alertMessage)"), dismissButton:
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
        }.onTapGesture {
            self.endEditing()
        }

    }

    public func Verify() {
        if email != "", password != "" {
            showLoader = true
            authVM.loginUser(email, password, onCompletion: { (_, errorObj) -> Void in
                showLoader = false
                if let _ = errorObj {
                    self.alertMessage = errorObj!.localizedDescription
                    self.alertTitle = SkyVPNConstants.Message.loginFailed.rawValue
                    self.alert.toggle()
                    return
                }
                UserDefaults.standard.set(true, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
                NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)

            })

        } else {
            alertTitle = SkyVPNConstants.Message.loginFailed.rawValue
            alertMessage = SkyVPNConstants.Message.emptyInputError.rawValue
            alert = true
        }
    }

    public func ResetPassword() {
        if email != "" {
            showLoader = true
            authVM.forgotUserPassword(email, onCompletion: { (_, errorObj) -> Void in
                showLoader = false
                if let _ = errorObj {
                    self.alertMessage = SkyVPNConstants.Message.generalError.rawValue
                    self.alert.toggle()
                    return
                }
                self.alertTitle = SkyVPNConstants.Message.passwordReset.rawValue
                self.alertMessage = SkyVPNConstants.Message.emailHasBeenSent.rawValue
                self.alert.toggle()
            })
        } else {
            alertMessage = SkyVPNConstants.Message.emptyEmail.rawValue
            alert.toggle()
        }
    }
    
    private func endEditing() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Login()
        }
    }
}
