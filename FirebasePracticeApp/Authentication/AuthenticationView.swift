//
//  AuthenticationView.swift
//  FirebasePracticeApp
//
//  Created by Berkay Disli on 21.03.2023.
//

import SwiftUI

struct AuthenticationView: View {
    @Binding var showSignInView: Bool

    var body: some View {
        VStack {
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
