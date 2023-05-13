//
//  EmailSignUpView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct EmailSignUpView: View {
    
    @Binding var showSignInView: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    
    let viewModel = EmailAuthenticationHandler()
    
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textFieldStyle()
                SecureField("Password", text: $password)
                    .textFieldStyle()
                SecureField("Re-enter Password", text: $passwordCheck)
                    .textFieldStyle()
                Button {
                    Task {
                        do {
                            try await viewModel.signUp(email: email, password: password, passwordCheck: passwordCheck)
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                    
                } label: {
                    Text("Sign Up")
                        .headingLabelStyle()
                }
                Spacer()
            }
        }
        .navigationTitle("Sign Up With Email")
    }
}

struct EmailSignUp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignUpView(showSignInView: .constant(false))
        }
    }
}

