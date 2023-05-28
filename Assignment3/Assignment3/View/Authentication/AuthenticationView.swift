//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


// Main authentication view with options for sign in with google
// and sign in with email
struct AuthenticationView: View {

    // Declare bool for showSignInView that will be set to false once user has signed in
    @Binding var showSignInView: Bool
    // Declare bool that is set to true if google sign in fails
    @State private var googleSignInError = false

    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 35) {
                Spacer()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .shadow(radius: 20)
                Text("Split Mate")
                    .font(.custom("Quicksand-Regular", size: 65))
                    .foregroundColor(ColorUtils.textColour)

                // Google sign in button that calls async signInGoogle
                // function from viewModel and sets showSignInView to false
                // once completed, displays error message if not sucessful
                Button {
                    Task {
                        do {
                            try await AuthenticationManager.shared.signInGoogleFlow()
                            showSignInView = false
                        } catch {
                            googleSignInError = true
                        }
                    }
                } label: {
                    HStack {
                        Image("GoogleLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        Text("Sign In With Google")
                            .font(.headline)
                            .foregroundColor(ColorUtils.textColour)
                    }
                        .headingLabelStyle()

                }

                // Navigation link that displays email sign in view and passes
                // the bound showSignInView bool
                NavigationLink {
                    EmailSignInView(showSignInView: $showSignInView)
                } label: {
                    HStack {
                        Image(systemName: "envelope")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        Text("Sign In With Email")
                            .font(.headline)
                            .foregroundColor(ColorUtils.textColour)
                    }
                        .headingLabelStyle()
                }
                Spacer()

                // Alert that is displayed if google sign in fails
                .alert("Could not sign in with Google", isPresented: $googleSignInError) {
                    Button("Ok", role: .cancel) { }
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
