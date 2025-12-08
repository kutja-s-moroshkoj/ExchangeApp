//
//  BaseStatView.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import SwiftUI

struct BaseStatView: View {
    @EnvironmentObject private var viewModel: BaseViewModel
    @Binding var showNextScreen: Bool
    
    var body: some View {
        
        HStack {
            ForEach(viewModel.statArray) { stat in
                StatisticComponent(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showNextScreen ? .trailing : .leading)
        
    }
}

#Preview {
    BaseStatView(showNextScreen: .constant(false))
        .environmentObject(BaseViewModel())
}
