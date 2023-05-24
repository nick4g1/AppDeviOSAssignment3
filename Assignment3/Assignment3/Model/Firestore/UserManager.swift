//
//  UserManager.swift
//  Split Mate
//
//  Created by Cooper Jacob on 19/5/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserProfile: Codable {
    let userId:String
    let email:String
    let photoUrl: String?
    let dateCreated:Date?
    var balance: Double
    var recieved: Double
    var sent: Double
    var friends: [String]
    var transactions: [String]

    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.balance = 0.0
        self.sent = 0.0
        self.recieved = 0.0
        self.friends = []
        self.transactions = []
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(email: String) -> DocumentReference {
        userCollection.document(email)
    }
    
    func createNewUser(user: UserProfile) async throws {
        try userDocument(email: user.email).setData(from: user, merge: false)
    }
    
    func getUser(email: String) async throws -> UserProfile {
        try await userDocument(email: email).getDocument(as: UserProfile.self)
    }
    
    // Could be changed to only update required fields
    func updateProfile(user: UserProfile) async throws {
        try userDocument(email: user.email).setData(from: user, merge: true)
    }
    
    func withdrawFunds(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.getUser(email: email)
        user.balance = user.balance - amount
        user.sent = user.sent + amount
        try await UserManager.shared.updateProfile(user: user)
    }
    
    func addFunds(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.getUser(email: email)
        user.balance = user.balance + amount
        user.recieved = user.recieved + amount
        try await UserManager.shared.updateProfile(user: user)
    }
    
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
    
    func addFriend(friendEmail: String) async throws {
        var user = try await UserManager.shared.loadCurrentUser()
        var friendArray = user.friends
        friendArray.append(friendEmail)
        user.friends = friendArray
        try await UserManager.shared.updateProfile(user: user)
    }
    
    func loadCurrentUser() async throws -> UserProfile {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        let user = try await UserManager.shared.getUser(email: authDataResult.email)
        return user
    }

}
