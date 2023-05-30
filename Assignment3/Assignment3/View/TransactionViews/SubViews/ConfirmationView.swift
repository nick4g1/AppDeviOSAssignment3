//
//  ConfirmationView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

// View to confirm or cancel the transaction
struct ConfirmationView: View {

    // Binding allow sending the amount from the previous view to this view and then to the confirmedView
    var amount: Double
    //Transactions is the transaction object that is passed to the view which contains information about transaction
    @State var transactions: [UserTransaction]
    //Variables for the case when the transaction is canceled and to go back to the view before
    @State private var isCancelled = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Do you want to execute this transaction of \(amount, format: .currency(code: "AUD"))?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(ColorUtils.textColour)
                    .multilineTextAlignment(.center)
                    .padding(.all)

                NavigationLink (
                    // Link to Confirmed view
                    destination: ConfirmedView(amount: amount, transactions: transactions),
                    label: {
                        Text("Confirm")
                            .confirmLabelStyle()
                    })
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .coloredLabelStyle(.red)
                }
            }
        }
    }
}



struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(amount: 100.0, transactions: [])
    }
}


