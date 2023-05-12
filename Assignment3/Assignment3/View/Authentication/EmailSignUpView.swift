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
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                SecureField("Re-enter Password", text: $passwordCheck)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
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
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
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

