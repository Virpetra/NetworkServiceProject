//
//  HomeView.swift
//  NetworkServiceProject
//
//  Created by Mehmet Said Dede on 8.02.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var networkManager = NetworkManager()
    @State private var coins: [CoinModel] = []
    
    var body: some View {
        
        
        List(coins, id: \.id) { coin in
            Text(coin.name)
        }
        .onAppear {
            fetchData()
        }
    }
    func fetchData() {
            networkManager.fetchData { result in
                switch result {
                case .success(let data):
                    if let decodedData = try? JSONDecoder().decode([CoinModel].self, from: data) {
                        DispatchQueue.main.async {
                            self.coins = decodedData
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
}

#Preview {
    HomeView()
}
