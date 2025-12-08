//
//  StatisticComponent.swift
//  ScreenEx
//
//  Created by Ростислав on 08.12.2025.
//

import SwiftUI

struct StatisticComponent: View {
    
    let statistic: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.caption)
                .foregroundStyle(Color.appColor.secondaryTextColor)
            Text(statistic.value)
                .font(.headline)
                .foregroundStyle(Color.appColor.accentAppcolor)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0 : 180)
                    )
                
                Text(statistic.percentageChange?.addPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((statistic.percentageChange ?? 0) >= 0 ? Color.appColor.colorPricesUp : Color.appColor.colorPricesDown)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
    }
}

#Preview {
    Group{
        StatisticComponent(statistic: DeveloperPreview.shared.statisticPlaceholder)
        StatisticComponent(statistic: DeveloperPreview.shared.statisticPlaceholder2)
        StatisticComponent(statistic: DeveloperPreview.shared.statisticPlaceholder3)
    }
}
