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
    
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        
        
        ZStack {
            //Background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
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
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
      .environmentObject(DeveloperPreview.instance.homeVM)

}

extension HomeView {
    
    private  var homeHeader: some View {
        
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(coins, id: \.id) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            fetchData()
        }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(coins, id: \.id) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            fetchData()
        }
    }
    
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
