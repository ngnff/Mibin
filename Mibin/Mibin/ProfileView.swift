//
//  ProfileView.swift
//  Mibin
//
//  Created by Слава on 29.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = TrashCardViewModel()
    
    @StateObject private var model = SignInEmailViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                
                HStack{
                    Text("Профиль")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.leading, 40.0)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            do {
                                try model.signOut()
                                showSignInView = true
                                return
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 30)
                            
                            Text("Выход")
                                .foregroundColor(.white)
                                .font(.system(.headline, design: .rounded))
                        }
                    }.padding(.horizontal)
                }
                
                Rectangle()
                    .frame(width: .infinity, height: 10)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                HStack{
                    Text("Данные:")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.leading, 40.0)
                    
                    Spacer()
                }
                
                ScrollView {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .foregroundColor(Color("frontcolor"))
                        
                        HStack{
                            Text("Имя пользователя:")
                                .foregroundColor(.white)
                                .font(.system(.headline, design: .rounded))
                            Text(viewModel.name)
                                .foregroundColor(.white)
                                .font(.system(.callout, design: .rounded))
                            Spacer()
                        }
                        .padding()
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .foregroundColor(Color("frontcolor"))
                        HStack{
                            Text("Email:")
                                .foregroundColor(.white)
                                .font(.system(.headline, design: .rounded))
                            Text(viewModel.email)
                                .foregroundColor(.white)
                                .font(.system(.callout, design: .rounded))
                            Spacer()
                        }
                        .padding()
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .foregroundColor(Color("frontcolor"))
                        
                        HStack{
                            Text("Задания:")
                                .foregroundColor(.white)
                                .font(.system(.headline, design: .rounded))
                            Spacer()
                        }
                        .padding()
                    }
                    
                    ForEach(viewModel.trashCards) { item in
                        NavigationLink{
                            DetailView(item: item)
                        }
                    label: {
                        CardView(item: item)}
                    }
                }
                .background(Color("background"))
                .padding(.horizontal)
                
                
                NavigationLink{
                    CreateTaskView()
                } label: {
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 200,height: 40)
                            .foregroundColor(.blue)
                        Text("Создать задание")
                            .foregroundColor(.white)
                            .font(.system(.callout, design: .rounded))
                        
                    }
                }
                .padding(.bottom)
            }.background(Color("background"))
        }
    }
}

#Preview {
    ProfileView(showSignInView: Binding.constant(false))
}

