//
//  EmailSignUpHandler.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation

enum SignInErrors: Error {
    case fieldsNotComplete(String)
    case passwordTooShort(String)
    case passwordsDontMatch(String)
}

final class EmailAuthenticationHandler {
    
    enum SignInErrors: Error {
        case fieldsNotComplete(String)
        case passwordTooShort(String)
        case passwordsDontMatch(String)
    }
    
    func signUp(email: String, password: String, passwordCheck: String) async throws {
        // TODO: Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }
        
        // Minimun password for Firebase is 6 characters
        guard password.count > 5 else {
            print("Password is too short")
            throw SignInErrors.passwordTooShort("Password is too short")
        }
        
        // Password validation to check 
        guard password == passwordCheck else {
            print("Passwords do not match")
            throw SignInErrors.passwordsDontMatch("Passwords do not match")
        }
        
        // Try to create user with given email and password
        let authDatResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = UserProfile(auth: authDatResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    // Function to sign in user given email and password
    func signIn(email: String, password: String) async throws {
        // TODO: Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            throw SignInErrors.fieldsNotComplete("Email or password field is empty")
        }
        
        // Try to sign in user with given email and password
        let returnUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
