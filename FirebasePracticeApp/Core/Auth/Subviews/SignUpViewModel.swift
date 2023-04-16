//
//  SignUpViewModel.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 16.04.2023.
//

import Foundation

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        print(returnedUserData)
        
        try await UserManager.shared.createNewUser(auth: returnedUserData)

        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        print(returnedUserData)
        
    }
}
