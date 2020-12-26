//
//  LoginView.swift
//  jingweili.me-mobile
//
//  Created by Jing Wei Li on 9/20/20.
//

import SwiftUI

struct LoginView: View {
    @State var passcode: String = ""
    @State var readyToLogin = false
    @ObservedObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.system(size: 30))
                .fontWeight(.black)
                .foregroundColor(.orange)
            SecureField("Enter your passcode", text: $passcode)
                .frame(width: 250, height: 50, alignment: .center)
                .padding(EdgeInsets(
                            top: 30,
                            leading: 0,
                            bottom: 30,
                            trailing: 0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Log In", action: { self.viewModel.login(with: passcode, completed: {
                self.readyToLogin = true
            }) })
                .frame(width: 250, height: 50, alignment: .center)
                .foregroundColor(.orange)
                .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.orange, lineWidth: 2))
                .sheet(isPresented: $readyToLogin, content: {
                    FileBrowserView()
                        .onDisappear {
                            self.passcode = ""
                            self.viewModel.logout()
                        }
                })
                
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(passcode: "Enter Passcode")
    }
}
