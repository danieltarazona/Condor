//
//  PokeDexDetailUIView.swift
//  Core
//
//  Created by Administrator on 5/21/21.
//

import SwiftUI

struct PokeDexDetailUIView: View {
    @ObservedObject private var interactor = PokeDexInteractor()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var name: String = "ditto"
    @State private var pokemon: Pokemon?
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        NavigationUIView(backTitle: "PokeDex", backAction:  {
            presentationMode.wrappedValue.dismiss()
        })
        ScrollView(showsIndicators: false) {
            Text("#\(pokemon?.order ?? 0) \(pokemon?.name?.capitalized ?? "")")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            PostUIView(images: pokemon?.spritesFormatted ?? [])
            HStack {
                HStack {
                    Text("Weight:")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text("\(String(pokemon?.weight  ?? 0))")
                        .font(.body)
                        .foregroundColor(Color.white)
                }
                HStack {
                    Text("Height:")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text("\(String(pokemon?.height ?? 0))")
                        .font(.body)
                        .foregroundColor(Color.white)
                }
            }
            
            Spacer(minLength: 16)
            Text("Types:")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(pokemon?.types ?? []) {
                PokemonTypeUIView(type: $0.type?.name ?? "")
            }
            Spacer(minLength: 16)
            Text("Moves:")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(pokemon?.moves ?? []) {
                TitleRowUIView(
                    subheadline: $0.move?.name?.capitalized ?? "",
                    subheadlineColor: .black
                )
            }
        }
        .navigationBarHidden(true)
        .padding(.horizontal)
        .background(Color.black)
        .onAppear(perform: {
            interactor.get(name: name)
        })
        .onReceive(interactor.$pokemon, perform: { pokemon in
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        })
        LikeUIView(
            leftTitle: "Dislike",
            rightTitle: "Like",
            leftImage: "bolt",
            rightImage: "bolt",
            leftAction: {
                if let pokemon = pokemon {
                    interactor.remove(pokemon: pokemon)
                }
            },
            rightAction: {
                if let pokemon = pokemon {
                    interactor.save(pokemon: pokemon)
                }
            }
        )
    }
}

struct PokeDexDetailUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexDetailUIView(name: "ditto")
    }
}
