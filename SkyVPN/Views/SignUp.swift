//
//  SignUp.swift
//  SkyVPN
//
//  Created by x218507 on 03/02/21.
//

import SwiftUI

struct SignUp: View {
    
    public var authVM = AuthVM()
    
    @State fileprivate var email = ""
    @State fileprivate var password = ""
    @State fileprivate var repassword = ""
    @State fileprivate var color = Color.black.opacity(0.7)
    @State fileprivate var visible = false
    @State fileprivate var revisible = false
    @State fileprivate var isLoading = false
    @State fileprivate var alert = false
    @State fileprivate var alertMessage = ""
    @State fileprivate var showLoader = false

    
    public var body: some View {
        
        //MARK:BaseView is for to support common features
        BaseView {
        VStack {
            Image("background").resizable().frame(width: 300.0, height: 255.0, alignment: .center)

            
            Text("Sign up a new account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(self.color)
                .padding(.top, 15)

            
            //MARK:- Email Field
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
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .stroke(Color(UIColor.appColor()), lineWidth: 2))
            .padding(.top, 10)

            //MARK:- Confirm Password Field
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

                //MARK:Secure Icon
                Button(action: {
                    self.revisible.toggle()
                        }) {
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
                .stroke(Color(UIColor.appColor()), lineWidth: 2))
            .padding(.top, 10)

            //MARK:- Loader
            ProgressView().show(showLoader)
            
            //MARK:Sign Up Button
            Button(action: {
                self.Register()
                    }) {
                Text("Sign up")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color(UIColor.appColor()))
            .cornerRadius(6)
            .padding(.top, 15)
            .alert(isPresented: self.$alert) { () -> Alert in
                Alert(title: Text("Sign up error"), message: Text("\(self.alertMessage)"), dismissButton:
                    .default(Text("OK").fontWeight(.semibold)))
            }
            

        }
        .padding(.horizontal, 25)
        }.onTapGesture {
            self.endEditing()
        }
    }
    

    public func Register() {
        if email != "" {
            if password == repassword {
                showLoader = true
                authVM.signUpUser(email, password, onCompletion: { (_, errorObj) -> Void in
                    showLoader = false
                    if let _ = errorObj {
                        self.alertMessage = errorObj!.localizedDescription
                        self.alert.toggle()
                        return
                    } else {
                        UserDefaults.standard.set(true, forKey: SkyVPNConstants.UserDefaultKeys.userStatus.rawValue)
                        NotificationCenter.default.post(name: NSNotification.Name(SkyVPNConstants.UserDefaultKeys.userStatus.rawValue), object: nil)
                    }
                })
            } else {
                alertMessage = SkyVPNConstants.Message.passwordMissMatch.rawValue
                alert.toggle()
            }
        } else {
            alertMessage = SkyVPNConstants.Message.emptyInputError.rawValue
            alert.toggle()
        }
    }
    
    fileprivate func endEditing() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
