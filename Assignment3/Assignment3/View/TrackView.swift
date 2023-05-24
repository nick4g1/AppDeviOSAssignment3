//
//  TrackView.swift
//  Split Mate
//
//  Created by Max Fisher on 5/20/23.
//

import SwiftUI

struct TrackView: View {
	
	//TODO: Keep track of transfers
	
    var body: some View {
		ZStack {
			ColorUtils.backgroundColor.edgesIgnoringSafeArea(.all)
			
			VStack {
				Spacer()
				Text("Total Transfers")
					.font(.headline)
				Spacer()
				Text("\(0, format: .currency(code: "AUD"))")
					.font(.largeTitle)
					.foregroundColor(.green)
				Spacer()
			}
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
