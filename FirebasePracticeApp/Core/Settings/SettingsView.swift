//
//  SettingsView.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 21.03.2023.
//

import SwiftUI



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
                
                Button(role: .destructive) {
                    Task {
                        do {
                            try await viewModel.deleteAccount()
                            showSignInView = true
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Delete account")
                }

                
                if viewModel.authProviders.contains(.email) {
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
                
                if viewModel.authUser?.isAnonymous == true {
                    Section {
                        Button("Link Google Account ") {
                            Task {
                                do {
                                    try await viewModel.linkGoogleAccount()
                                    print("password reset")
                                } catch {
                                    print(error)
                                }
                            }
                        }
                        
                        
                        Button("Link email account") {
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
                        Text("Account")
                    }
                }

            }
            .onAppear(perform: {
                viewModel.loadAuthProviders()
                viewModel.loadAuthUser()
            })
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
