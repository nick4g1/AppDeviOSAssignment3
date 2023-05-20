//
//  AuthenticationModel.swift
//  Assignment3
//
//  Created by Cooper Jacob on 12/5/2023.
//

import Foundation
import FirebaseAuth

// Creating a struct to store only the needed data from the returned Firebase user object
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

// Setting class as final as no inheritance will be used
final class AuthenticationManager {
    // Only 1 instance of this class will be created to be used across the app
    static let shared = AuthenticationManager()
    private init() { }
    
    // Try to retrieve the current user from local storage else throw an error
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            // TODO: Should throw custom error here
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // Use Firebase to create a new user based on provided email and password
    func createUser(email: String, password:String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign in with email and password
    func signInUser(email: String, password:String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // Sign in with Google using credential token
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signInWithCredential(credential: credential)
    }
    
    // Sign in with crdential function used with Google + Apple sign in
    func signInWithCredential(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // TODO: Function to reset password NOT IMPLEMENTED
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // Signs out the current account
    func signOut() throws {
        try Auth.auth().signOut()
    }
}