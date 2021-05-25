//
//  PokeDexUIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/21/21.
//

import SwiftUI

struct PokeDexUIView: View {
    @ObservedObject private var interactor: PokeDexInteractor
    @State var isLoading: Bool = false
    @State var showDetail: Bool = false
    @State var showLiked: Bool = false
    
    init() {
        interactor = PokeDexInteractor()
        interactor.getAllSpecies()
        interactor.createIndex()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextUIView(title: "PokeDex", darkMode: true)
                    NavigationLink(
                        destination: PokeDexSelectedUIView(pokemons: interactor.pokemonSelected),
                        isActive: $showLiked,
                        label: {
                            ButtonUIView(title: "Liked", leftImage: "", rightImage: "") {
                                self.showLiked = true
                                interactor.getAllVoted()
                            }
                        })
                }
                .background(Color.black)
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(interactor.pokemonSpecies) { specy in
                        NavigationLink(
                            destination: PokeDexDetailUIView(name: specy.name ?? "")
                        ) {
                            TitleRowUIView(
                                title: specy.name?.capitalized ?? "",
                                shadowRadius: 0
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea([.top, .bottom])
                .alert(isPresented: $interactor.networkManager.offline) {
                    Alert(
                        title: Text("Error"),
                        message: Text("No Internet Connection"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                PaginationUIView(
                    title: "Gen",
                    leftTitle: "Prev",
                    rightTitle: "Next",
                    page: interactor.generation,
                    totalPage: interactor.totalGeneration,
                    leftAction: {
                        interactor.decrease()
                    }, rightAction: {
                        interactor.increase()
                    }
                )
                .background(Color.black)
            }
            .background(Color.red)
        }
        
    }
}

#if DEBUG
struct PokeDexUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDexUIView()
    }
}
#endif
