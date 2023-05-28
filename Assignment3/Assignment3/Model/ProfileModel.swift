//
//  ProfileModel.swift
//  Split Mate
//
//  Created by Cooper Jacob on 13/5/2023.
//

import Foundation

final class ProfileModel: ObservableObject {
    
    @Published var user: UserProfile? = nil
    @Published var name: String = ""
    @Published var friendToAdd = ""
    
    @MainActor
    func loadUser() async throws {
        self.user = try await UserManager.shared.loadCurrentUserDocument()
        name = self.user?.name ?? ""
    }

}


