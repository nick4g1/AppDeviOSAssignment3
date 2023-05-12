//
//  EmailSignUpHandler.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation

final class EmailAuthenticationHandler {
    
    func signUp(email: String, password: String, passwordCheck: String) async throws {
        // Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        guard password.count > 5 else {
            print("Password is too short")
            return
        }
        
        guard password == passwordCheck else {
            print("Passwords do not match")
            return
        }
        let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        print("Success")
        print(returnUserData)
    }
    
    func signIn(email: String, password: String) async throws {
        // Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        let returnUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        print("Success")
        print(returnUserData)
    }
}
