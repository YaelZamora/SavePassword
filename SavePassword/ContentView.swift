//
//  ContentView.swift
//  SavePassword
//
//  Created by Yael Javier Zamora Moreno on 02/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var passwordManager = PasswordManager()
    @State private var showingAddPassword = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(passwordManager.passwords) { password in
                    NavigationLink(destination: PasswordDetailView(password: password)) {
                        VStack(alignment: .leading) {
                            Text(password.title)
                                .font(.headline)
                            Text(password.username)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: passwordManager.deletePassword)
            }
            .navigationTitle("Passwords")
            .toolbar {
                Button(action: {
                    showingAddPassword = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPassword) {
                AddPasswordView(passwordManager: passwordManager)
            }
        }
    }
}

#Preview {
    ContentView()
}
