//
//  SendMoneyView.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyView: View {
    @State private var value = 0.0
    private var numberFormatter: NumberFormatter
	@StateObject private var viewModel = ProfileModel()
    //Friends
    @State private var selectedFriends: Set<String> = []
    @State var friends:[Friend] = []
    //Initialize number formatter for CurrencyTextField
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
            self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
            self.numberFormatter.maximumFractionDigits = 2
    }
	
    var body: some View {
        ZStack {
			if let user = viewModel.user {
				ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
				VStack(){
                    HStack {
                        Text("Send")
                            .font(.custom("Quicksand-Regular", size: 45))
                            .foregroundColor(.black)
                        Image(systemName: "paperplane.circle")
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                    }

					//Title as navigation title
					//Creates text field using CurrencyTextField and NumberFormatter initialized above
					CurrencyTextField(numberFormatter: numberFormatter, value: $value)
						.padding(20)
						.overlay(RoundedRectangle(cornerRadius: 16)
							.stroke(Color.gray.opacity(0.3), lineWidth: 2))
						.frame(height: 100)
					Spacer()
					Text("Friend List").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30)).padding(.all)
					// Here comes the scrollstack
					FriendsScrollView(amount: $value, selectedFriends: $selectedFriends, friends: friends, toSplit: false)
					Spacer()
					//Link to confirmation view
					NavigationLink {
						var transactions: [UserTransaction] {
							var result: [UserTransaction] = []
							for friend in selectedFriends {
								let transaction = UserTransaction(transactionId: "\(friend)\(Date())", amount: value / Double(selectedFriends.count), sendingAccount: user.email, recievingAccount: friend, date: Date())
								result.append(transaction)
							}
							return result
						}
						ConfirmationView(amount: $value, transactions: transactions)
					} label: {
						Text("Send")
							.sendReceiveStyle()
					}
					//Check to make sure value is properly created
					Text(String(format: "Sending: $%.02f", value))
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
    
    struct SendMoneyView_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyView()
        }
    }
}
