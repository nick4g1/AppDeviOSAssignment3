//
//  ProfileModel.swift
//  Split Mate
//
//  Created by Cooper Jacob on 13/5/2023.
//

import Foundation

final class ProfileModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }

}
