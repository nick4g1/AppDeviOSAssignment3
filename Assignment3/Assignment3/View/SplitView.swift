import SwiftUI

struct SplitView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var amount = 0.0
    @State private var selectedFriends: Set<String> = []
    let friends = Friends().generateFriends()
    
    var body: some View {
        ZStack {
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
                Text("With Who?")
                    .font(.title)
                Section {
                    FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends, toSplit: true)
                }
                Section {
                    NavigationLink {
                        ConfirmationView(amount: $amount, transactions: [])
                    } label: {
                        Text("Confirm")
                            .confirmLabelStyle()
                            .padding(.bottom)
                    }
                }
                
            }
        }
        .navigationBarTitle("Split", displayMode: .large)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    amountIsFocused = false
                }
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
