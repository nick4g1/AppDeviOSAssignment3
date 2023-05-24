//
//  TrackView.swift
//  Split Mate
//
//  Created by Max Fisher on 5/20/23.
//

import SwiftUI

struct TrackView: View {
	
	//TODO: Keep track of transfers
	@StateObject private var viewModel = ProfileModel()
	
	let total = 100
	
    var body: some View {
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
						Text("Net Transfers")
							.font(.headline)
						Spacer()
						Text("\(user.recieved - user.sent < 0 ? "(":"")\(total, format: .currency(code: "AUD"))\(total < 0 ? ")":"")")
							.foregroundColor(total < 0 ? .red:.green)
					}
				}
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
