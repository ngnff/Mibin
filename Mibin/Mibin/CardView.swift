//
//  CardView.swift
//  Mibin
//
//  Created by Слава on 20.05.2024.
//

import SwiftUI

struct CardView: View {
    
    var item: Model
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("frontcolor"))
                .cornerRadius(20)
                .frame(height: 170)
                .padding(.horizontal)
            VStack{
                Text("\(item.country), \(item.city), \(item.street), \(item.house)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .font(.system(.headline, design: .rounded))
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundColor(Color("background"))
                        .frame(height: 110)
                        .offset(CGSize(width: 0, height: 10))
                        .padding(.horizontal, 20.0)
                    HStack{
                        
                        if let url = URL(string: item.imageUrl) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .frame(width: 75, height: 75)
                                    .cornerRadius(10)
                                    .padding(.leading, 40)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer()
                            
                            Text(item.description)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .font(.system(.callout ,design: .rounded))
                                .padding(.trailing, 30)
                        }
                    }
                    .offset(CGSize(width: 0.0, height: 10.0))
                }
            }
        }
    }
}

#Preview {
    CardView(item: Model(country: "Россия", city: "Саратов", street: "Тархова", house: "14", status: "доступен", description: "Убрать мусор с детской площадки", imageUrl: "", createdBy: "Сергей Родионов", creatorId: "7IyIPR46udWwulTL5TgDSIVKzcd2"))
}
