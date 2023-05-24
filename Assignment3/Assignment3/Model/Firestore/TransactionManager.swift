//
//  TransactionManager.swift
//  Split Mate
//
//  Created by Cooper Jacob on 24/5/2023.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct UserTransaction: Codable {
    let transactionId:String
    let amount:Double
    let sendingAccount: String
    let recievingAccount:String
    let date: Date?
    
}

final class TransactionManager {
    
    static let shared = TransactionManager()
    private init() {}
    
    private let transactionCollection = Firestore.firestore().collection("transactions")

    private func transactionDocument(transactionId: String) -> DocumentReference {
        transactionCollection.document(transactionId)
    }
    
    func createNewTransaction(transaction: UserTransaction) async throws {
        try transactionDocument(transactionId: transaction.transactionId).setData(from: transaction, merge: false)
        try await UserManager.shared.addFunds(amount: transaction.amount, email: transaction.recievingAccount)
        try await UserManager.shared.withdrawFunds(amount: transaction.amount, email: transaction.sendingAccount)
        try await UserManager.shared.addTransaction(transaction: transaction)
    }
    
    func getTransaction(transactionId: String) async throws -> UserTransaction {
        try await transactionDocument(transactionId: transactionId).getDocument(as: UserTransaction.self)
        
    }



}
