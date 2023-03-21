//
//  SettingsView.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 21.03.2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
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
}

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            List {
                Button("Sign Out") {
                    Task {
                        do {
                            try viewModel.signOut()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                }
                
                Section {
                    Button("Reset password") {
                        Task {
                            do {
                                try await viewModel.resetPassword()
                                print("password reset")
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                    Button("Update password") {
                        Task {
                            do {
                                try await viewModel.updatePassword()
                                print("password updated")
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                    Button("Update email") {
                        Task {
                            do {
                                try await viewModel.updateEmail()
                                print("email updated")
                            } catch {
                                print(error)
                            }
                        }
                    }
                } header: {
                    Text("Auth functions")
                }

            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
