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
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .shadow(radius: 20)
                Text("Sign In With Email")
                    .font(.custom("Quicksand-Regular", size: 40))
                TextField("Email...", text: $email)
                    .textFieldStyle()
                SecureField("Password...", text: $password)
                    .textFieldStyle()
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
                        .headingLabelStyle()
                }
                NavigationLink {
                    EmailSignUpView(showSignInView: $showSignInView)
                } label: {
                    Text("Don't have an account?")
                        .subHeadingLabelStyle()
                }
                Spacer()
            }
        }
    }
}

struct EmailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmailSignInView(showSignInView: .constant(false))
        }
    }
}
