//
//  ButtonUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct ButtonUIView: View {
    var title: String = ""
    var titleColor: Color = .black
    
    var leftImage: String = "bolt"
    var rightImage: String = "bolt"
    
    var backgroundColor: Color = .white
    var cornerRadius: CGFloat = 8
    
    var shadowOpacity: Double = 0.3
    var shadowRadius: CGFloat = 4
    
    var action: () -> Void = {}
    
    
    
    var body: some View {
        HStack(spacing: 4) {
            leftImage.isEmpty ? AnyView(leftIcon) : nil
            Button(action: action, label: {
                Text(title)
            })
            rightImage.isEmpty ? AnyView(leftIcon) : nil
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .foregroundColor(titleColor)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(
            color: Color.black.opacity(shadowOpacity),
            radius: shadowRadius
        )
    }
    
    var leftIcon: some View {
        Image(systemName: leftImage)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(titleColor)
            .background(backgroundColor)
    }
    
    var rightIcon: some View {
        Image(systemName: rightImage)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(titleColor)
            .background(backgroundColor)
    }
}

#if DEBUG
struct ButtonUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonUIView()
    }
}
#endif
