//
//  ControllerView.swift
//  Mibin
//
//  Created by Слава on 29.05.2024.
//

import SwiftUI

struct ControllerView: View {
    
    @State var selectedView = 0

    @Binding var showSignInView: Bool
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedView){
                MainView()
                    .tag(0)
                
                ProfileView(showSignInView: $showSignInView)
                    .tag(1)
                
                SettingsView()
                    .tag(2)
            }
            .accentColor(.gray)
            
            HStack{
                Spacer()
                
                Button {
                    selectedView = 0
                } label: {
                    if(selectedView == 0)
                    {
                        Image(systemName: "house")
                            .foregroundColor(.gray)                            
                    } else {
                        Image(systemName: "house")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                }
                
                Spacer()
                
                Button {
                    selectedView = 1
                } label: {
                    if(selectedView == 1)
                    {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "person")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                }
                
                Spacer()
                
                Button {
                    selectedView = 2
                } label: {
                    if(selectedView == 2)
                    {
                        Image(systemName: "gearshape")
                            .foregroundColor(.gray)
                    } else {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                            .imageScale(.large)
                    }
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("frontcolor"))
        }
    }
}

#Preview {
    ControllerView(showSignInView: Binding.constant(false))
}
