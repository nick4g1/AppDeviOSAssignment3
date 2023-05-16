//
//  SendMoneyNumberPad.swift
//  Assignment3
//
//  Created by Nick Forgione on 13/5/2023.
//

import SwiftUI

struct SendMoneyNumberPad: View {
    @State private var amount = "$"
    @State private var amountDouble = 0.0
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(){
                Spacer()
                Text(amount).frame(width: 300, height: 100, alignment: .center).font(.system(size: 35))
                Spacer()
                //Number Pad
                HStack(){
                    // 1 Number Button
                    Spacer()
                    Button(action: {
                        amount = amount + "1"
                    }) {
                        Text("1")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 2 Number Button
                    Button(action: {
                        amount = amount + "2"
                    }) {
                        Text("2")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 3 Number Button
                    Button(action: {
                        amount = amount + "3"
                    }) {
                        Text("3")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // 4 Number Button
                    Button(action: {
                        amount = amount + "4"
                    }) {
                        Text("4")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 5 Number Button
                    Button(action: {
                        amount = amount + "5"
                    }) {
                        Text("5")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 6 Number Button
                    Button(action: {
                        amount = amount + "6"
                    }) {
                        Text("6")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // 7 Number Button
                    Button(action: {
                        amount = amount + "7"
                    }) {
                        Text("7")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 8 Number Button
                    Button(action: {
                        amount = amount + "8"
                    }) {
                        Text("8")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 9 Number Button
                    Button(action: {
                        amount = amount + "9"
                    }) {
                        Text("9")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    Spacer()
                }
                HStack(){
                    Spacer()
                    // . Number Button
                    Button(action: {
                        amount = amount + "."
                    }) {
                        Text(".")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    // 0 Number Button
                    Button(action: {
                        amount = amount + "0"
                    }) {
                        Text("0")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    Spacer()
                    // Back Number Button
                    Button(action: {
                        amount = String(amount.dropLast())
                    }) {
                        Text("<-")
                            .padding(.horizontal, 50)
                            .padding(.vertical, 25)
                    }.foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                    Spacer()
                }
            }
        }
    }
    
    struct SendMoneyNumberPad_Previews: PreviewProvider {
        static var previews: some View {
            SendMoneyNumberPad()
        }
    }
}
