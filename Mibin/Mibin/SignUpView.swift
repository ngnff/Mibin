//
//  SignUpView.swift
//  Mibin
//
//  Created by Слава on 29.05.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("background"))
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color("frontcolor"))
                .frame(maxWidth: .infinity, maxHeight: 270)
                .offset(CGSize(width: 0.0, height: -55.0))
                .padding()
            
            VStack
            {
                Text("Регистрация")
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
                
                TextField("Имя", text: $viewModel.name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button{
                    Task {
                        do {
                            try await viewModel.signUp()
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
                        
                        Text("Зарегестрироваться")
                            .foregroundColor(.white)
                            .font(.system(.title2, design: .rounded))
                    }
                }.padding()
            }.padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SignUpView(showSignInView: Binding.constant(false))
}
