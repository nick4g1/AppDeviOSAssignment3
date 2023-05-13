//
//  ConfirmationView.swift
//  Assignment3
//
//  Created by Adrian Nikaeen on 13.05.23.
//

import SwiftUI

struct ConfirmationView: View {
    @State private var translation: CGFloat = 0
    @State private var isCancelled = false
    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Do you want to execute this transaction?")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                                NavigationLink {
                                    // Link to split view
                                } label: {
                                    Text("Confirm")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(height: 55)
                                        .frame(maxWidth: .infinity)
                                        .background(.green)
                                        .cornerRadius(10)
                                        .shadow(radius: 10)
                                        .padding(.horizontal)
                                }
                
                                
                
                
                
                //                Text("Slide left to Cancel and right to Confirm")
                //                HStack{
                //                    Image(systemName: "arrow.left.and.right")
                //                        .font(.title)
                //                        .foregroundColor(.blue)
                //                        .padding()
                //                        .background(Color.gray.opacity(0.2))
                //                        .cornerRadius(10)
                //                        .offset(x: isCancelled ? -min(300, translation) : translation)
                //                        .gesture(
                //                            DragGesture()
                //                                .onChanged { value in
                //                                    if value.translation.width < 0 {
                //                                        translation = max(value.translation.width, -300)
                //                                    } else {
                //                                        translation = 0
                //                                    }
                //                                }
                //                                .onEnded { value in
                //                                    if value.translation.width < -100 {
                //                                        withAnimation {
                //                                            isCancelled = true
                //                                        }
                //                                    } else {
                //                                        withAnimation {
                //                                            translation = 0
                //                                        }
                //                                    }
                //                                }
                //                        )
                //                        .frame(maxWidth: .infinity)
                //                        .clipped()
                //                }
                //
                //            }
                //        }
                
                
                
                //                NavigationLink {
                //                    // Link to split view
                //                } label: {
                //                    Text("")
                //                        .headingLabelStyle()
                //                }
                
            }
            
        }
    }
}



struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
