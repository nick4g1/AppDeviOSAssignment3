import SwiftUI

// View for splitting an amount with multiple friends
struct SplitView: View {

    // Focus state to allow dismissing of keyboard when tapped elsewhere
    @FocusState private var amountIsFocused: Bool

    // Variable for amount entered into textfield
    @State private var amount = 0.0

    // Variable for selected friends and array of all friends on profile
    @State private var selectedFriends: Set<String> = []
    @StateObject private var viewModel = ProfileModel()
    @State var friends: [Friend] = []

    var body: some View {
        ZStack {

            // If user is loaded then load view
            if let user = viewModel.user {
                ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    HStack {
                        Text("Split")
                            .font(.custom("Quicksand-Regular", size: 45))
                            .foregroundColor(.black)
                        Image(systemName: "divide.circle.fill")
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
                    Text("With Who?")
                        .font(.title)
                    Section {
                        FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends, toSplit: true)
                    }
                    Section {
                        NavigationLink {

                            // Pass an array of UserTransaction to the confirmation view
                            var transactions: [UserTransaction] {
                                var result: [UserTransaction] = []
                                for friend in selectedFriends {
                                    let transaction = UserTransaction(transactionId: "\(friend)\(Date())", amount: amount / Double(selectedFriends.count), sendingAccount: friend, recievingAccount: user.email, date: Date())
                                    result.append(transaction)
                                }
                                return result
                            }
                            ConfirmationView(amount: $amount, transactions: transactions)
                        } label: {
                            Text("Split")
                                .sendReceiveStyle()
                        }
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

            // Load the user and friends list after the view has loaded
            try? await viewModel.loadUser()
            do {
                friends = try await UserManager.shared.getFriends()
            } catch {
                print(error)
            }
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SplitView()
        }

    }
}
