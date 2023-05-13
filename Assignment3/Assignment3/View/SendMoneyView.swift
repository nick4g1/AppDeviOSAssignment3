//
//  SendMoneyView.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyView: View {
    @State private var amount = 0.0
    //Pass friend type to send
    //@State private var friend: Friend
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(){
                //Title as navigation title
                Spacer()
                TextField("Amount...", value: $amount, format: .currency(code: "USD"))
                    .textFieldStyle().keyboardType(.numberPad)
                Text("Friend List").frame(maxWidth: .infinity, alignment: .leading).font(.system(size: 30)).padding(.all)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<10) {
                            Text("Item \($0)")
                                .headingLabelStyle()
                        }
                    }
                }
                .frame(height: 250)
                
                Spacer()
            label: do {
                Text("Send")
                    .sendReceiveStyle()
                Spacer()
            }
            }
            .navigationTitle("Send Money")
        }
    }
    
    struct SendMoneyView_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyView()
        }
    }
}
