//
//  CreateTaskView.swift
//  Mibin
//
//  Created by Слава on 30.05.2024.
//

import SwiftUI

struct CreateTaskView: View {
    
    @EnvironmentObject var viewModel: TrashCardViewModel
    
    @State private var country: String = ""
    @State private var city: String = ""
    @State private var street: String = ""
    @State private var house: String = ""
    @State private var description: String = ""
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("Создание")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.leading, 40.0)
                    
                    Spacer()
                }
                
                Rectangle()
                    .frame(width: .infinity, height: 10)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding([.leading, .bottom, .trailing])
                
                TextField("Страна", text: $country)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Город", text: $city)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Улица", text: $street)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Дом", text: $house)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Описание", text: $description)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    viewModel.addTrashCard(country: country, city: city, street: street, house: house, status: "Доступно", description: description, imageUrl: "")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 50)
                        
                        Text("Создать")
                            .foregroundColor(.white)
                            .font(.system(.headline, design: .rounded))
                    }
                }.padding()
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
    }
}

#Preview {
    CreateTaskView().environmentObject(TrashCardViewModel())
}
