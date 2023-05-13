//
//  ConfirmationView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var amount: Double
    @State private var translation: CGFloat = 0
    @State private var isCancelled = false
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Do you want to execute this transaction?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                                NavigationLink (
                                    // Link to Confirmed view
                                destination: ConfirmedView(amount: $amount),
                                 label: {
                                    Text("Confirm")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .background(.green)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .padding(.horizontal)
                                })
            }
        }
    }
}



struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(amount: .constant(0.0))
    }
}


