//
//  AuthView.swift
//  TestOut5
//
//  Created by Brendan Sick on 9/4/24.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel: AuthViewModel = AuthViewModel()
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack {
            Text("TestOut iOS App")
                .font(.title)
                .bold()
            TextField("Email", text: $viewModel.emailText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            if viewModel.isPasswordVisible {
                SecureField("Password", text: $viewModel.passwordText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .textInputAutocapitalization(.never)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button {
                    viewModel.authenticate(appState: AppState())
                } label: {
                    Text(viewModel.userExists ? "Log in": "Create Account")
                }
                .padding()
                .foregroundStyle(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            }
         
    }
}

#Preview {
    AuthView()
}
