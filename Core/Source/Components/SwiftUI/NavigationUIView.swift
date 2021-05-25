//
//  NavigationUIView.swift
//  Core
//
//  Created by Administrator on 5/22/21.
//

import SwiftUI

struct NavigationUIView: View {
    var backTitle: String = "Back"
    var nextTitle: String = ""
    
    var backAction: () -> Void = {}
    var nextAction: () -> Void = {}
    
    var body: some View {
        HStack {
            ButtonUIView(title: backTitle, leftImage: "chevron.backward", action: {
              backAction()
            })
            Spacer()
            !nextTitle.isEmpty ? ButtonUIView(title: nextTitle, action: {
              nextAction()
            }) : nil
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .background(Color.black)
    }
}

struct NavigationUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationUIView()
    }
}
