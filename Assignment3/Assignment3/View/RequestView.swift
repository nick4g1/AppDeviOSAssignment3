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
                Text("From Who?")
                    .font(.title)
                // Here comes the scrollstack
                FriendsScrollView(amount: $amount, selectedFriends: $selectedFriends, friends: friends, toSplit: false)
                //
                Spacer()
                NavigationLink(
                    destination: ConfirmationView(amount: $amount),
                    label: {
                        Text("Request")
                            .confirmLabelStyle()
                    }
                )

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
        
        
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RequestView()
        }
    }
}
