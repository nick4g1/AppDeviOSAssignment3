//
//  ConfirmationView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var amount: Double
    @State var transactions: [UserTransaction]
    @State private var translation: CGFloat = 0
    @State private var isCancelled = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Do you want to execute this transaction of $\(amount, format: .currency(code: "AUD"))?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(ColorUtils.textColour)
                    .multilineTextAlignment(.center)
                    .padding(.all)

                NavigationLink (
                    // Link to Confirmed view
                    destination: ConfirmedView(amount: $amount, transactions: transactions),
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
        ConfirmationView(amount: .constant(0.0), transactions: [])
    }
}


