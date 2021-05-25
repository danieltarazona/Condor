//
//  AvatarUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct AvatarUIView: View {
    var user: User?
    
    var shadowRadius: CGFloat = 8
    var size: CGFloat = 32
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 9) {
                ImageUIView(name: user?.profile_pic ?? "", height: size, width: size)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0) {
                    Text(user?.name ?? "")
                        .font(.custom("Roboto-Bold", size: 12))
                    Text(user?.email ?? "")
                        .font(.custom("Roboto-Regular", size: 11))
                }
            }
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: size)
    }
}

#if DEBUG
struct AvatarUIView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarUIView()
    }
}
#endif
