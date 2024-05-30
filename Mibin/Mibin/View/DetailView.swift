//
//  DetailView.swift
//  Mibin
//
//  Created by Слава on 21.05.2024.
//

import SwiftUI

struct DetailView: View {
    
    var item: Model
    
    var body: some View {
        ZStack{
            if let url = URL(string: item.imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable(resizingMode: .tile)
                } placeholder: {
                    ProgressView()
                }
            }
            ScrollView{
                detail()
            }.offset(CGSize(width: 0.0, height: 300.0))
        }.ignoresSafeArea()
    }
    
    @ViewBuilder
    private func detail() -> some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("background"))
                .cornerRadius(40)
                .frame(height: 600)
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("frontcolor"))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    HStack{
                        
                        Text("Состояние:")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text(item.status)
                            .font(.system(.callout, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }.padding(.horizontal)
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("frontcolor"))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    HStack{
                        
                        Text("Адрес:")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("\(item.country), \(item.city), \(item.street), \(item.house)")
                            .font(.system(.callout, design: .rounded))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }.padding(.horizontal)
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("frontcolor"))
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    HStack{
                        Text("Создатель:")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text(item.createdBy)
                            .font(.system(.callout, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal)
                }
                
                
                HStack{
                    ZStack(){
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("frontcolor"))
                            .frame(maxWidth: 150, maxHeight: 50)
                        
                        Text("Описание:")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                ZStack(alignment: .topLeading){
                    
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(Color("frontcolor"))
                        .frame(height: 200)
                    
                    Text(item.description)
                        .font(.system(.callout, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                }
                
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 50)
                        
                        Text("Принять")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.white)
                    }
                }.padding(.bottom)
            }
            .frame(height: 400)
            .padding()
        }
    }
}

#Preview {
    DetailView(item: Model(country: "Россия", city: "Саратов", street: "Тархова", house: "14", status: "доступен", description: "Убрать мусор с детской площадки", imageUrl: "", createdBy: "Сергей Родионов", creatorId: "7IyIPR46udWwulTL5TgDSIVKzcd2"))
}
