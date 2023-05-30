//
//  ConfirmedView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

// View is used to display when you have confirmed the transaction.
struct ConfirmedView: View {

    //Binding allow sending the amount to this view
    var amount: Double
    //Transactions is the transaction object that is passed to the view which contains information about transaction
    @State var transactions: [UserTransaction]
    //The variable is set to true when firebase successfully loads the transaction
    @State private var confirmed = false

    var body: some View {
        ZStack {
            if confirmed {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 200))
                        .foregroundColor(Color(red: 0, green: 0.9, blue: 0))
                        .shadow(color: .white, radius: 10)

                    Text("Your transaction of \(amount, format: .currency(code: "AUD")) has been completed")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(ColorUtils.textColour)
                        .multilineTextAlignment(.center)
                    NavigationLink {
                        InitialView()
                    } label: {
                        Text("Main Menu")
                            .headingLabelStyle()
                    }

                }
            }
        }
            .task {
            do {
                for transaction in transactions {
                    try await TransactionManager.shared.createNewTransaction(transaction: transaction)
                }
                confirmed = true
            } catch {
                confirmed = false
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct ConfirmedView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmedView(amount: 100.0, transactions: [])
    }
}
