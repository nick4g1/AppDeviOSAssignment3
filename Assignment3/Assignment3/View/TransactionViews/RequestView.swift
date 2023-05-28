//
//  RequestView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct RequestView: View {
    //@Binding private var passTotalAmount = 0.0
    //@State private var selectedPage: Page = RequestView()
    @FocusState private var amountIsFocused: Bool
    @State private var amount = 0.0
    @State private var selectedFriends: Set<String> = []
	@StateObject private var viewModel = ProfileModel()
    @State var friends:[Friend] = []
    
    var body: some View {
		ZStack {
			if let user = viewModel.user {
				ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
				VStack(spacing: 20) {
					Spacer()
					HStack {
						Text("Amount:")
							.font(.title)
						TextField("Amount", value: $amount, format: .currency(code: "AUD"))
							.numberFieldStyle()
							.focused($amountIsFocused)
					}
					.alternatelabelStyle()
					Text("From Who?")
						.font(.title)
					// Here comes the scrollstack
					FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends, toSplit: false)
					Spacer()
					NavigationLink {
						var transactions: [UserTransaction] {
							var result: [UserTransaction] = []
							for friend in selectedFriends {
									
								let transaction = UserTransaction(transactionId: "\(friend)\(Date())", amount: amount / Double(selectedFriends.count), sendingAccount: friend, recievingAccount: user.email, date: Date())
								result.append(transaction)
							}
							return result
						}
						ConfirmationView(amount: $amount, transactions:  transactions)
					} label: {
						Text("Request")
							.sendReceiveStyle()
					}
					
				}
			}

        }
        .navigationBarTitle("Request", displayMode: .large)
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button("Done") {
					amountIsFocused = false
				}
			}
		}
        .task {
            try? await viewModel.loadUser()
            if let user = viewModel.user {
                do {
                    friends = try await UserManager.shared.getFriends()
                } catch {
                    print(error)
                }
            }
        }
        
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RequestView()
        }
    }
}
