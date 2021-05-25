//
//  FeedUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import SwiftUI

struct FeedUIView: View {
    @ObservedObject var interactor = FeedInteractor()
    @State var isLoading: Bool = false
    
    var body: some View {
        isLoading ? ProgressView()
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
            .frame( maxWidth: .infinity, maxHeight: 32, alignment: .top)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isLoading = false
                    if !isLoading {
                        interactor.getUsers()
                    }
                }
            }) : nil
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(interactor.users) {
                AvatarUIView(user: $0)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ForEach($0.posts ?? []) { post in
                    PostUIView(images: post.pics ?? [])
                }
            }
        }
        .gesture(DragGesture().onChanged({ _ in
            isLoading = true
        }))
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
        .alert(isPresented: $interactor.networkManager.offline) {
            Alert(
                title: Text("Error"),
                message: Text("No internet connection."),
                dismissButton: .default(Text("Got it!"))
            )
        }
    }
}

#if DEBUG
struct FeedUIView_Previews: PreviewProvider {
    static var previews: some View {
        FeedUIView()
    }
}
#endif
