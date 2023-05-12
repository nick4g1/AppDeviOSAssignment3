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
    
    @State private var viewModel = EmailAuthenticationHandler()
    
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                TextField("Email...", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                SecureField("Password...", text: $password)
                    .padding()
                    .background(Color.white)
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
                        .padding()
                        .foregroundColor(.white)
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
