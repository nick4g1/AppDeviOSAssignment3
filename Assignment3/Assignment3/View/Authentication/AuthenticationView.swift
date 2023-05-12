//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = AuthenticationHandler()
    var body: some View {
            ZStack {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .padding()
                    .shadow(radius: 20)
                    NavigationLink {
                        EmailSignInView(showSignInView: $showSignInView)
                    } label: {
                        Text("Sign In With Email")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                            .shadow(radius: 20)
                            .padding()
                    }
                }
            }
            .navigationTitle("Sign In")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
