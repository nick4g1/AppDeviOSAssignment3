//
//  EmailSignUpHandler.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation

final class EmailAuthenticationHandler {
    
    func signUp(email: String, password: String, passwordCheck: String) async throws {
        
        // Input validation that throws errors if it fails
        
        // Check if email or password field empty
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }
        
        // Password validation to check passwords match
        guard password == passwordCheck else {
            throw SignInErrors.passwordsDontMatch("Passwords do not match")
        }
        
        // Try to create user with given email and password
        let authDatResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = UserProfile(auth: authDatResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    // Function to sign in user given email and password
    func signIn(email: String, password: String) async throws {
        
        // Check if email or password field is empty
        guard !email.isEmpty, !password.isEmpty else {
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }
        
        // Try to sign in user with given email and password
       try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
