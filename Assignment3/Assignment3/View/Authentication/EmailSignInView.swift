//
//  EmailSignInView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct EmailSignInView: View {
    
    @Binding var showSignInView: Bool
    @State private var email = ""
    @State private var password = ""
    
    let viewModel = EmailAuthenticationHandler()
    
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                TextField("Email...", text: $email)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .autocapitalization(.none)
                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(email: email, password: password)
                            showSignInView = false
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Sign In With Email")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 200)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink {
                    EmailSignUpView(showSignInView: $showSignInView)
                } label: {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: 200)
                        .background(.black)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Sign In With Email")
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignInView(showSignInView: .constant(false))
        }
    }
}
