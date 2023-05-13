import SwiftUI

struct SplitView: View {
    @State private var amount = 0.0
    @State private var selectedFriends: Set<String> = []
    let friends = Friends().generateFriends()
    
    var totalAmount: Double {
        selectedFriends.count > 0 ? amount / Double(selectedFriends.count) : 0
    }
    
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Split")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                HStack {
                    Text("Amount")
                    TextField("Amount", value: $amount, format: .currency(code: "AUD"))
                        .frame(width: 100)
                        .background(.white)
                        .padding()
                }
                FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends)
                NavigationLink {
                    MainMenuView(showSignInView: .constant(false))
                } label: {
                    Text("Confirm")
                        .headingLabelStyle()
                }
            }
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
