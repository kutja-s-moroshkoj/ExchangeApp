//
//  CustomButtonAnimation.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

struct CustomButtonAnimation: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 5)
            .scale(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(.easeOut(duration: 1), value: animate)
            .foregroundStyle(Color.appColor.accentAppcolor)
    }
}

#Preview {
    CustomButtonAnimation(animate: .constant(false))
        .frame(width: 55, height: 55)
}
