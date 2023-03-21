//
//  SignUpWithEmalView.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 21.03.2023.
//

import SwiftUI

@MainActor
final class SignUpWithEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        print(returnedUserData)
        
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        print(returnedUserData)
        
    }
}

struct SignUpWithEmalView: View {
    @StateObject private var viewModel = SignUpWithEmailViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            TextField("email", text: $viewModel.email)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            SecureField("password", text: $viewModel.password)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignInView = false
                        // if this works, task is done.
                        return
                    } catch {
                        print(error)
                    }
                    
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        // if doesnt, this do cath runs.
                        return
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
            Spacer()

        }
        .padding()
        .navigationTitle("Sign up with email")
    }
}

struct SignUpWithEmalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpWithEmalView(showSignInView:.constant(false)) 
        }
    }
}
