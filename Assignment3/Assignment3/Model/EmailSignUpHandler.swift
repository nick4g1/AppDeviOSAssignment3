//
//  EmailSignUpHandler.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation

final class EmailSignUpHandler {
    
    static let shared = EmailSignUpHandler()
    private init() { }

    func signIn(email: String, password: String) {
        // Add validation here
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        guard password.count > 5 else {
            print("Password is too short")
            return
        }
        
        Task {
            do {
                let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnUserData)
            } catch {
                print("Error \(error)")
            }
        }
    }
}
