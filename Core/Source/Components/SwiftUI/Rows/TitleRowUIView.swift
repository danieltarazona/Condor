//
//  TitleRowUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct TitleRowUIView: View {
    @State var title: String = ""
    var titleFont: Font = .title
    var titleColor: Color = .primary
    
    var subheadline: String = ""
    var subheadlineFont: Font = .title2
    var subheadlineColor: Color = .secondary
    
    var cornerRadius: CGFloat = 8
    var shadowRadius: CGFloat = 4
    var shadowOpacity: Double = 0.3
    
    var background: Color = .white
    
    var rightImage: String = ""
    
    var body: some View {
        HStack{
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8, content: {
                Text(title.capitalized)
                    .font(titleFont)
                    .foregroundColor(titleColor)
                Text(subheadline)
                    .font(subheadlineFont)
                    .foregroundColor(subheadlineColor)
                Spacer()
                !rightImage.isEmpty ? ButtonUIView(rightImage: rightImage, cornerRadius: 0, shadowRadius: 0) : nil
            })
            .padding()
            .background(background)
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(shadowOpacity),
                    radius: shadowRadius
            )
        }
    }
}

struct TitleRowUIView_Previews: PreviewProvider {
    static var previews: some View {
        TitleRowUIView()
    }
}
