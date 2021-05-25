//
//  LikeUIView.swift
//  Core
//
//  Created by Administrator on 5/24/21.
//

import SwiftUI

struct LikeUIView: View {
    var leftTitle: String = ""
    var rightTitle: String = ""
    
    var leftImage: String = ""
    var rightImage: String = ""
    
    var leftAction: () -> Void = {}
    var rightAction: () -> Void = {}
    
    @State var darkMode: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
            ButtonUIView(
                title: leftTitle,
                rightImage: leftImage,
                action: leftAction
            )
            Spacer()
            ButtonUIView(
                title: rightTitle,
                rightImage: rightImage,
                action: rightAction
            )
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(16)
    }
}

struct LikeUIView_Previews: PreviewProvider {
    static var previews: some View {
        LikeUIView()
    }
}
