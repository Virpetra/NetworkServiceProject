//
//  NetworkServiceProjectApp.swift
//  NetworkServiceProject
//
//  Created by Mehmet Said Dede on 8.02.2024.
//

import SwiftUI

@main
struct NetworkServiceProjectApp: App {
    
    @StateObject private var vm = NetworkManager()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
