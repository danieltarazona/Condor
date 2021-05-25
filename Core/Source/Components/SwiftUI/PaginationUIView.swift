//
//  PaginationUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct PaginationUIView: View {
    var title: String = ""
    
    var leftTitle: String = ""
    var rightTitle: String = ""
    
    var page: Int = 1
    var totalPage: Int = 1
    
    var withTitle: Bool = false
    
    var leftImage: String = ""
    var rightImage: String = ""
    
    var leftAction: () -> Void = {}
    var rightAction: () -> Void = {}
    
    @State var darkMode: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
            page != 1 ? ButtonUIView(
                title: leftTitle,
                rightImage: leftImage,
                action: leftAction
            ) : nil
            HStack(spacing: 8) {
                title.isEmpty ? Spacer() : nil
                Text(title)
                    .foregroundColor(darkMode ? .white : .black)
                Text(String(page))
                    .foregroundColor(darkMode ? .white : .black)
                Text("/")
                    .foregroundColor(darkMode ? .white : .black)
                Text(String(totalPage))
                    .foregroundColor(darkMode ? .white : .black)
            }
            page != totalPage ?
                ButtonUIView(
                    title: rightTitle,
                    rightImage: rightImage,
                    action: rightAction
                ) : nil
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
}

#if DEBUG
struct PaginationUIView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationUIView()
    }
}
#endif
