//
//  AuthenticationView.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signInGoogle()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = AuthenticationViewModel()
    var body: some View {
            ZStack {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .shadow(radius: 20)
                    Text("Split Mate")
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    Button{
                        Task {
                            do {
                                try await viewModel.signInGoogle()
                                showSignInView = false
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        HStack {
                            Image("GoogleLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)// SF Symbols image
                            Text("Sign In With Google")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    }
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
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView: .constant(false))
        }

    }
}
