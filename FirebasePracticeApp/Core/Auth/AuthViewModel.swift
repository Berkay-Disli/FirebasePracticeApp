//
//  AuthViewModel.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 16.04.2023.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInWithGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        
        try await UserManager.shared.createNewUser(auth: authDataResult)

    }
    
    func signInAnonymously() async throws {
        
        let authDataResult = try await AuthenticationManager.shared.signInAnonymously()
        
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
