//
//  RootView.swift
//  Mibin
//
//  Created by Слава on 30.05.2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            ControllerView(showSignInView: $showSignInView)
        }
        .onAppear{
            let authuser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authuser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            SignInView(showSignInView: $showSignInView)
        })
    }
}

#Preview {
    RootView()
}
