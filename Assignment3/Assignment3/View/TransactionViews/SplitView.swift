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
    
    // Number formatter for initialization
    private var numberFormatter: NumberFormatter
    
    //Initialize number formatter for CurrencyTextField
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.maximumFractionDigits = 2
        self.numberFormatter.locale = Locale.current
    }
    
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
                    //Creates text field using CurrencyTextField and NumberFormatter initialized above
                    CurrencyTextField(numberFormatter: numberFormatter, value: $amount)
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                        .frame(width: 400, height: 100)
                    Spacer()
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
