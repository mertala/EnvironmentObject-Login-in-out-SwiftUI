//
//  ContentView.swift
//  out-SwiftUI
//
//  Created by Mert Ala on 4.02.2020.
//  Copyright © 2020 Mert Ala. All rights reserved.
//

import SwiftUI

struct ContentView:View {
    
    @State var isPresent:Bool = false
    @EnvironmentObject var model:UserView
    
    var body: some View {
        VStack {
            Button(action: {
                self.isPresent.toggle()
            }) {
                Text("Oturum").font(.headline)
                    .foregroundColor(.blue)
            }.sheet(isPresented: $isPresent, content: {
                LoginView().environmentObject(self.model)
            
                })
                Divider()
            Text("\(self.model.user.isAuth ? "Oturumu Açık" : "Oturumu Kapalı")").font(.headline)
             
        }
    }
}


struct User {
    var isAuth:Bool = false
}
 
class UserView: ObservableObject {
    
    @Published var user = User()
    
    func login() {
        user.isAuth = true
    }
    func logout() {
        user.isAuth = false
    }
}



struct LoginView:View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var model:UserView
    
    var body: some View {
        VStack {
            Button(action: {
                self.model.login()
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Giriş")
            }.font(.headline)
            Divider()
            Button(action: {
                self.model.logout()
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Çıkış")
                    .font(.headline)
            }
        }
    }
}
