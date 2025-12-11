//
//  XMarkButton.swift
//  ScreenEx
//
//  Created by Ростислав on 10.12.2025.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundStyle(Color.appColor.accentAppcolor)
                .font(.headline)
        }
    }
}

#Preview {
    XMarkButton()
}
