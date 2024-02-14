//
//  CircleButtonView.swift
//  NetworkServiceProject
//
//  Created by Mehmet Said Dede on 14.02.2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10)
            .padding()
    }
}

#Preview {
    Group {
        CircleButtonView(iconName: "info")
        .previewLayout(.sizeThatFits)
        
        CircleButtonView(iconName: "plus")
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.dark)
    }
}