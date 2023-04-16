//
//  AuthenticationView.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 21.03.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift





struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await viewModel.signInAnonymously()
                        showSignInView = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign Up Anonymously")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                SignUpWithEmalView(showSignInView: $showSignInView)
            } label: {
                Text("Sign Up with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }

            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInWithGoogle()
                        showSignInView = false
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthenticationView(showSignInView:.constant(false))
        }
    }
}
