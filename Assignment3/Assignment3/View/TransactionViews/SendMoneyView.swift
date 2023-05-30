//
//  SendMoneyView.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyView: View {

    // Variable for amount entered into textfield
    @State private var amount = 0.0

    // Focus state to allow dismissing of keyboard when done is pressed
    @FocusState private var amountIsFocused: Bool

    // Variable for selected friends and array of all friends on profile
    @StateObject private var viewModel = ProfileModel()
    @State private var selectedFriends: Set<String> = []
    @State var friends: [Friend] = []


    var body: some View {
        ZStack {
            if let user = viewModel.user {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack() {
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
                    HStack {
                        Text("Amount:")
                            .font(.title)
                        TextField("Amount", value: $amount, format: .currency(code: "AUD"))
                            .numberFieldStyle()
                            .focused($amountIsFocused)
                    }
                        .alternatelabelStyle()
                    Spacer()
                    Text("From Who?")
                        .font(.title)
                    // Here comes the scrollstack
                    FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends, toSplit: false)
                    Spacer()
                    //Link to confirmation view
                    NavigationLink {
                        var transactions: [UserTransaction] {
                            var result: [UserTransaction] = []
                            for friend in selectedFriends {
                                let transaction = UserTransaction(transactionId: "\(friend)\(Date())", amount: amount / Double(selectedFriends.count), sendingAccount: user.email, recievingAccount: friend, date: Date())
                                result.append(transaction)
                            }
                            return result
                        }
                        ConfirmationView(amount: $amount, transactions: transactions)
                    } label: {
                        Text("Send")
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

    struct SendMoneyView_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyView()
        }
    }
}
