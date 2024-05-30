//
//  SignInView.swift
//  Mibin
//
//  Created by Слава on 29.05.2024.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    
    func signUp() async throws
    {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password, userName: name)
    }
    
    func signIn() async throws
    {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    func signOut() throws
    {
        try AuthenticationManager.shared.signOut()
    }
    
    func getAuth() throws -> AuthDataResultModel {
        return try AuthenticationManager.shared.getAuthenticatedUser()
    }
}

struct SignInView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("background"))
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("frontcolor"))
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .offset(CGSize(width: 0.0, height: -55.0))
                    .padding()
                
                VStack
                {
                    Text("Вход")
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                    
                    TextField("Почта", text: $viewModel.email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    SecureField("Пароль", text: $viewModel.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button{
                        Task {
                            do {
                                try await viewModel.signIn()
                                showSignInView = false
                                return
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .foregroundColor(.blue)
                            
                            Text("Войти")
                                .foregroundColor(.white)
                                .font(.system(.title2, design: .rounded))
                        }
                    }.padding()
                    
                    NavigationLink {
                        SignUpView(showSignInView: $showSignInView)
                    } label: {
                        Text("Зарегистрироваться")
                    }
                }.padding()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignInView(showSignInView: Binding.constant(false))
}
