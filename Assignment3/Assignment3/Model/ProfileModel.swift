//
//  ProfileModel.swift
//  Split Mate
//
//  Created by Cooper Jacob on 13/5/2023.
//

import Foundation

final class ProfileModel: ObservableObject {
    
    @Published private(set) var user: UserProfile? = nil
    
    func loadUser() async throws {
        self.user = try await UserManager.shared.loadCurrentUser()
    }

}
