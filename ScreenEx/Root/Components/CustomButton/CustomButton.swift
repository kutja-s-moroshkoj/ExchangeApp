//
//  CustomButton.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

struct CustomButton: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.appColor.accebtAppcolor)
            .frame(width: 55, height: 55)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.appColor.backgroundAppcolor)
            )
            .shadow(color: Color.appColor.accebtAppcolor.opacity(0.4),
                    radius: 10,
                    x: 0,
                    y: 0)
            .padding()
    }
}

#Preview {
    Group {
        CustomButton(iconName: "info.square")
        CustomButton(iconName: "plus.viewfinder")
            .colorScheme(.dark)
    }
}
