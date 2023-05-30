//
//  RequestView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

// View for requesting an amount from multiple friends
struct RequestView: View {

    // Focus state to allow dismissing of keyboard when tapped elsewhere
    @FocusState private var amountIsFocused: Bool
    // Variable for amount entered into textfield
    @State private var amount = 0.0
    // Variable for selected friends
    @State private var selectedFriends: Set<String> = []
    @StateObject private var viewModel = ProfileModel()
    @State var friends: [Friend] = []

    var body: some View {
        ZStack {
            if let user = viewModel.user {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    HStack {
                        Text("Request")
                            .font(.custom("Quicksand-Regular", size: 45))
                            .foregroundColor(.black)
                        Image(systemName: "dollarsign.arrow.circlepath")
                            .resizable()
                            .foregroundColor(.black)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                    }
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

                                let transaction = UserTransaction(transactionId: "\(friend)\(Date())", amount: amount, sendingAccount: friend, recievingAccount: user.email, date: Date())
                                result.append(transaction)
                            }
                            return result
                        }
                        ConfirmationView(amount: (amount * Double(selectedFriends.count)), transactions: transactions)
                    } label: {
                        Text("Request")
                            .sendReceiveStyle()
                    }

                }
            }

        }
            .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
            .task {
            try? await viewModel.loadUser()
            do {
                friends = try await UserManager.shared.getFriends()
            } catch {
                print(error)
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
