//
//  BaseScreen.swift
//  ScreenEx
//
//  Created by Ростислав on 02.12.2025.
//

import SwiftUI

struct BaseScreen: View {
    
    @State private var goToTheNextScreen: Bool = false
    
    var body: some View {
        
        ZStack {
            //задний фон
            Color.appColor.backgroundAppcolor
                .ignoresSafeArea()
            //контент
            VStack{
                baseScreenHeader
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        BaseScreen()
            .toolbar(.hidden)
    }
}


extension BaseScreen {
    private var baseScreenHeader: some View {
        HStack {
            CustomButton(iconName: goToTheNextScreen ? "plus.viewfinder" : "info.square.fill")
                .background(CustomButtonAnimation(animate: $goToTheNextScreen))
            Spacer()
            Text(goToTheNextScreen ? "PORTFOLIO" : "EXCHANGE")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.appColor.accebtAppcolor)
                .animation(.none)
            Spacer()
            CustomButton(iconName: "arrowtriangle.forward")
                .rotationEffect(Angle(degrees: goToTheNextScreen ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        goToTheNextScreen.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
