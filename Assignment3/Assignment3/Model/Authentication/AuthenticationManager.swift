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
    let email: String
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email ?? ""
        self.photoUrl = user.photoURL?.absoluteString
    }
}


final class AuthenticationManager {

    // Shared instance of class is declared to be used across application
    static let shared = AuthenticationManager()
    private init() { }

    // Try to retrieve the current user from local storage else throw an error
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw ApplicationError.UserNotRetrieved
        }

        return AuthDataResultModel(user: user)
    }

    // Use Firebase to create a new user based on provided email and password
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }

    // Sign in with email and password
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }

    // Sign in with Google using credential token
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signInWithCredential(credential: credential)
    }

    // Launches Google Sign In pop up and create news document for user if sign-in successful
    @MainActor
    func signInGoogleFlow() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.signInGoogle()
        let authDataResult = try await signInWithGoogle(tokens: tokens)
        let user = UserProfile(auth: authDataResult)
        let userDocument = try? await UserManager.shared.getUser(email: user.email)
        if userDocument == nil {
            try await UserManager.shared.createNewUser(user: user)
        }
    }

    // Sign in with crdential function used with Google
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
