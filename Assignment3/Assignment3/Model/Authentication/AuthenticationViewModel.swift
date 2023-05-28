//
//  AuthenticationViewModel.swift
//  Split Mate
//
//  Created by Cooper Jacob on 19/5/2023.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signInGoogle()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = UserProfile(auth: authDataResult)
        let userDocument = try? await UserManager.shared.getUser(email: user.email)
        if userDocument == nil {
            try await UserManager.shared.createNewUser(user: user)
        }
    }
}
