//
//  ContentView.swift
//  Mibin
//
//  Created by Слава on 20.05.2024.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel = TrashCardViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                header()
                
                ScrollView(.vertical, showsIndicators: true){
                    ForEach(viewModel.trashCards) { item in
                        NavigationLink{
                            DetailView(item: item)
                        }
                    label: {
                        CardView(item: item)}
                    }
                }
                .background(Color("background"))
                
                bottom() 
                
            }.background(Color("background"))
        }
    }
    
    @ViewBuilder
    private func bottom() -> some View{
        VStack{
            Rectangle()
                .frame(width: .infinity, height: 10)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding([.leading, .bottom, .trailing])
        
        }
    }
    
    @ViewBuilder
    private func header() -> some View
    {
        VStack{
            HStack{
                Text("Mibin")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .bold()
                    .padding(.leading, 40.0)
                
                Spacer()
            }
            
            Rectangle()
                .frame(width: .infinity, height: 10)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            HStack{
                Text("Задания")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(width: .infinity)
                    .padding(.leading, 40.0)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
