//
//  ProfileView.swift
//  Split Mate
//
//  Created by Jake Isaacs on 22/5/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileModel()
    let transaction = UserTransaction(transactionId: "1111", amount: 200.00, sendingAccount: "cooper1@gmail.com", recievingAccount: "cooperj97@gmail.com", date: Date())
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserID: \(user.userId)")
                Text("Balance: \(user.balance)")
                Button {
                    Task {
                        do {
                            try await TransactionManager.shared.createNewTransaction(transaction: transaction)
                            try? await viewModel.loadUser()
                        } catch {
                            print(error)
                        }
                    }
                    
                } label: {
                    Text("Make Transaction")
                }
            }
            
        }
        .task {
            try? await viewModel.loadUser()
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack {
                ProfileView()
            }
        }
    }
}
