//
//  PokeDexSelectedUIView.swift
//  Core
//
//  Created by Administrator on 5/24/21.
//

import SwiftUI

struct PokeDexSelectedUIView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var pokemons: [Pokemon] = []
    
    var body: some View {
        NavigationUIView(backTitle: "Home", backAction:  {
            presentationMode.wrappedValue.dismiss()
        })
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(pokemons) { pokemon in
                    NavigationLink(
                        destination: PokeDexDetailUIView(name: pokemon.name ?? "")
                    ) {
                        TitleRowUIView(
                            title: pokemon.name?.capitalized ?? ""
                        )
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.top, .bottom])
    }
}

struct PokeDexSelectedUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexSelectedUIView()
    }
}
