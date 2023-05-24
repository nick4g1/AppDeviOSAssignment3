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
    let email:String?
    let photoUrl: String?
    let dateCreated:Date?
    var balance: Double
    var recieved: Double
    var sent: Double
    var friends: [String]

    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.balance = 0.0
        self.sent = 0.0
        self.recieved = 0.0
        self.friends = []
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")

    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private func userDocument(email: String) -> DocumentReference {
        userCollection.document(email)
    }
    
    func createNewUser(user: UserProfile) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }

    
    func getUser(userId: String) async throws -> UserProfile {
        try await userDocument(userId: userId).getDocument(as: UserProfile.self)
        
    }
    
    func getFriendProfile(email: String) async throws -> UserProfile {
        try await userDocument(email: email).getDocument(as: UserProfile.self)
    }
    
    // Could be changed to only update required fields
    func updateProfile(user: UserProfile) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: true)
    }
    
    func sendMoney(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.loadCurrentUser()
        user.balance = user.balance - amount
        user.sent = user.sent + amount
        try await UserManager.shared.updateProfile(user: user)
    }
    
    func requestMoney(amount: Double, email: String) async throws {
        var user = try await UserManager.shared.loadCurrentUser()
        user.balance = user.balance + amount
        user.sent = user.recieved + amount
        try await UserManager.shared.updateProfile(user: user)
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
        let user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        return user
    }

}
