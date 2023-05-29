//
//  TrackView.swift
//  Split Mate
//
//  Created by Max Fisher on 5/20/23.
//

import SwiftUI
import SwiftUICharts

struct TrackView: View {

    //TODO: Keep track of transfers
    @StateObject private var viewModel = ProfileModel()

    var body: some View {
        ZStack {
            ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Track ")
                        .font(.custom("Quicksand-Regular", size: 45))
                        .foregroundColor(.black)
                    Image(systemName: "list.clipboard.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                }
                List {
                    if let user = viewModel.user {
                        Section {
                            HStack {
                                Text("Total Sent")
                                Spacer()
                                Text("\(user.sent, format: .currency(code: "AUD"))")
                                    .foregroundColor(.red)
                            }
                            HStack {
                                Text("Total Recieved")
                                Spacer()
                                Text("\(user.recieved, format: .currency(code: "AUD"))")
                                    .foregroundColor(.green)
                            }
                            HStack {
                                let total = user.recieved - user.sent
                                Text("Net Transfers")
                                    .font(.headline)
                                Spacer()
                                Text("\(total < 0 ? "(" : "")\(total, format: .currency(code: "AUD"))\(total < 0 ? ")" : "")")
                                    .foregroundColor(total < 0 ? .red : .green)
                            }
                        }
                        Section {
                            VStack {
                                Text("Transactions")
                                    .font(.custom("Quicksand-Regular", size: 25))
                                Text("Sent and Recieved")
                                    .font(.custom("Quicksand-Regular", size: 15))
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 7)
                                VStack {
                                    PieChart()
                                        .data([user.sent, user.recieved])
                                        .chartStyle(ChartStyle(backgroundColor: .white,
                                        foregroundColor: [ColorGradient(.red, .orange),
                                            ColorGradient(.yellow, .green),]))
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Circle()
                                                .fill(ColorGradient(.red, .orange).linearGradient(from: .bottom, to: .top))
                                                .frame(width: 24.0, height: 24.0)
                                            Text("Sent \(user.sent, format: .currency(code: "AUD"))")
                                        }
                                        HStack {
                                            Circle()
                                                .fill(ColorGradient(.green, .yellow).linearGradient(from: .bottom, to: .top))
                                                .frame(width: 24.0, height: 24.0)
                                            Text("Recieved \(user.recieved, format: .currency(code: "AUD"))")
                                        }
                                    }
                                }
                            }
                        }
                            .frame(height: 350)

                    }
                }
                    .scrollContentBackground(.hidden)

            }
        }

            .task {
            try? await viewModel.loadUser()
        }

    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TrackView()
        }
    }
}
