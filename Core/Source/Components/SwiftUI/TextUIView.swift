//
//  TextUIView.swift
//  Core
//
//  Created by Administrator on 5/22/21.
//

import SwiftUI

struct TextUIView: View {
    var title: String = ""
    var darkMode: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(darkMode ? .white : .black)
            Spacer()
        }
        .frame(height: 64, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct TextUIView_Previews: PreviewProvider {
    static var previews: some View {
        TextUIView()
    }
}
