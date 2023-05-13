//
//  EmailSignUpHandler.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation

final class EmailAuthenticationHandler {
    
    func signUp(email: String, password: String, passwordCheck: String) async throws {
        // TODO: Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        // Minimun password for Firebase is 6 characters
        guard password.count > 5 else {
            print("Password is too short")
            return
        }
        
        // Password validation to check 
        guard password == passwordCheck else {
            print("Passwords do not match")
            return
        }
        
        // Try to create user with given email and password
        let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        print("Success")
        print(returnUserData)
    }
    
    // Function to sign in user given email and password
    func signIn(email: String, password: String) async throws {
        // TODO: Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        // Try to sign in user with given email and password
        let returnUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        print("Success")
        print(returnUserData)
    }
}
