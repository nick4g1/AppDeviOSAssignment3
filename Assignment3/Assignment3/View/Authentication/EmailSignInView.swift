//
//  EmailSignInView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI

struct EmailSignInView: View {

    // Binding for showSignInView that will be set to false once user is logged in
    @Binding var showSignInView: Bool

    // Variables for email, password and error handling
    @State private var email = ""
    @State private var password = ""
    @State private var signUpError = false
    @State private var errorMessage = ""

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

                // When button is pressed call signIn function and display any errors
                // with alert popup
                Button {
                    Task {
                        do {
                            try await viewModel.signIn(email: email, password: password)
                            showSignInView = false
                        } catch let error as SignInErrors {
                            // Basic input validation issues raise custom error
                            signUpError = true
                            errorMessage = error.localizedDescription
                        } catch {
                            // Displays any errors thrown by Firebase
                            signUpError = true
                            errorMessage = error.localizedDescription
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
                        .alternatelabelStyle()
                }
                Spacer()
                // Alert that displays error message localizedDescription and has button to dismiess
                .alert(errorMessage, isPresented: $signUpError) {
                    Button("Ok", role: .cancel) { }
                }
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
