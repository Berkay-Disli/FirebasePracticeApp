//
//  SettingsViewModel.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 16.04.2023.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders = [AuthProviderOption]()
    @Published var authUser: AuthDataResultModel? = nil
    
                                                    
    func loadAuthProviders()  {
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else { throw URLError(.fileIsDirectory) }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "berkay22"
        try await AuthenticationManager.shared.updatePassword(password: password)
        
    }
    
    func updateEmail() async throws {
        let email = "new-email@testing.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func linkGoogleAccount() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
        self.authUser = authDataResult
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
    }
    
    
    
}
