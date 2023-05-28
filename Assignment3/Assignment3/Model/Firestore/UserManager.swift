//
//  UserManager.swift
//  Split Mate
//
//  Created by Cooper Jacob on 19/5/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Struct for user profile - conforms to codable so it can be encoded
// and decoded for mapping to key values in firestore

struct UserProfile: Codable {
    let userId: String
    let email: String
    var name: String
    let photoUrl: String?
    let dateCreated: Date
    var balance: Double
    var recieved: Double
    var sent: Double
    var friends: [String]
    var transactions: [String]


    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.name = ""
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.balance = 0.0
        self.sent = 0.0
        self.recieved = 0.0
        self.friends = []
        self.transactions = []
    }
}

// Class for interacting with user collection on firestore

final class UserManager {

    // Shared instance of class is declared to be used across application
    static let shared = UserManager()
    private init() { }

    // Set userCollection to firestore collection "users"
    private let userCollection = Firestore.firestore().collection("users")

    // Retrieves user docuement given user email
    private func userDocument(email: String) -> DocumentReference {
        userCollection.document(email)
    }

    // Creates a new user document with email as the identifier
    func createNewUser(user: UserProfile) async throws {
        try userDocument(email: user.email).setData(from: user, merge: false)
    }

    // Retrieves the user document as a UserProfile object when given an email
    func getUser(email: String) async throws -> UserProfile {
        try await userDocument(email: email).getDocument(as: UserProfile.self)
    }

    // Updates a user profile with a given UserProfile object
    func updateProfile(user: UserProfile) async throws {
        try userDocument(email: user.email).setData(from: user, merge: true)
    }

    // Decreases a users balance and increases the sent amount on a user's profile
    func withdrawFunds(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.getUser(email: email)
        user.balance = user.balance - amount
        user.sent = user.sent + amount
        try await UserManager.shared.updateProfile(user: user)
    }

    // Increases a users balance and increases the recieved amount on a user's profile
    func addFunds(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.getUser(email: email)
        user.balance = user.balance + amount
        user.recieved = user.recieved + amount
        try await UserManager.shared.updateProfile(user: user)
    }

    // Adds a new transaction to both sender and recievers accounts
    func addTransaction(transaction: UserTransaction) async throws {

        // Add transaction to sender
        var sender = try await UserManager.shared.getUser(email: transaction.sendingAccount)
        var transactionArraySender = sender.transactions
        transactionArraySender.append(transaction.transactionId)
        sender.transactions = transactionArraySender
        try await UserManager.shared.updateProfile(user: sender)

        // Add transaction to reciever
        var reciver = try await UserManager.shared.getUser(email: transaction.recievingAccount)
        var transactionArrayReciever = reciver.transactions
        transactionArrayReciever.append(transaction.transactionId)
        reciver.transactions = transactionArrayReciever
        try await UserManager.shared.updateProfile(user: reciver)
    }

    // Adds another users email to friend array of signed in profile
    func addFriend(friendEmail: String) async throws {
        var user = try await UserManager.shared.loadCurrentUser()
        var friendArray = user.friends
        friendArray.append(friendEmail)
        user.friends = friendArray
        try await UserManager.shared.updateProfile(user: user)
    }

    // Loads the user document from firestore for the currently signed in user
    func loadCurrentUser() async throws -> UserProfile {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        let user = try await UserManager.shared.getUser(email: authDataResult.email)
        return user
    }

}
