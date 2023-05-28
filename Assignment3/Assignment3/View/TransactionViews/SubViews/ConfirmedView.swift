//
//  ConfirmedView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct ConfirmedView: View {
    @Binding var amount: Double
	@State var transactions: [UserTransaction]
	
	@State private var confirmed = false
    var body: some View {
        ZStack {
			if confirmed {
				ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
				
				VStack {
					Image(systemName: "checkmark.circle.fill")
						.font(.system(size: 200))
						.foregroundColor(.green)
						.shadow(radius: 10)
						.frame(maxHeight: UIScreen.main.bounds.height / 2)
					
					Text("Your transaction of \(amount, format: .currency(code: "AUD")) has been excuted")
						.font(.title2)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.multilineTextAlignment(.leading)
					Spacer()
					
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
    }
}

struct ConfirmedView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmedView(amount: .constant(0.0), transactions: [])
    }
}
