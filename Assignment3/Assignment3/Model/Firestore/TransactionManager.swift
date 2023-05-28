//
//  TransactionManager.swift
//  Split Mate
//
//  Created by Cooper Jacob on 24/5/2023.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Struct for user transaction - conforms to codable so it can be encoded
// and decoded for mapping to key values in firestore

struct UserTransaction: Codable {
    let transactionId:String
    let amount:Double
    let sendingAccount: String
    let recievingAccount:String
    let date: Date?
    
}

final class TransactionManager {
    
    // Shared instance of class is declared to be used across application
    static let shared = TransactionManager()
    private init() {}
    
    // Set transactionCollection to firestore collection "transactions"
    private let transactionCollection = Firestore.firestore().collection("transactions")

    // Retrieves a transaction docuement given user email
    private func transactionDocument(transactionId: String) -> DocumentReference {
        transactionCollection.document(transactionId)
    }
    
    // Creates a new transaction given a UserTransaction object
    func createNewTransaction(transaction: UserTransaction) async throws {
        try transactionDocument(transactionId: transaction.transactionId).setData(from: transaction, merge: false)
        try await UserManager.shared.addFunds(amount: transaction.amount, email: transaction.recievingAccount)
        try await UserManager.shared.withdrawFunds(amount: transaction.amount, email: transaction.sendingAccount)
        try await UserManager.shared.addTransaction(transaction: transaction)
    }
    
    // Retrieves a transaction given a transaction ID
    func getTransaction(transactionId: String) async throws -> UserTransaction {
        try await transactionDocument(transactionId: transactionId).getDocument(as: UserTransaction.self)
        
    }



}
