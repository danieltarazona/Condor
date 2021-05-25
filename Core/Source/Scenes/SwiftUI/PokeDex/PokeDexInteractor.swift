//
//  PokeDexInteractor.swift
//  Core
//
//  Created by Daniel Tarazona on 5/21/21.
//

import Foundation
import CouchbaseLiteSwift

// Property Expression
let ID = Meta.id
let NAME = Expression.property("name")
let LIKED = Expression.property("liked")
let POKEMON = Expression.property("pokemon")

// SelectResult
let SR_ALL = SelectResult.all()
let SR_ID = SelectResult.expression(ID)
let SR_COUNT = SelectResult.expression(Function.count(Expression.int(1)))
let SR_IMAGE = SelectResult.property("image")
let SR_NAME = SelectResult.expression(NAME)
let SR_LIKED = SelectResult.expression(LIKED)
let SR_POKEMON = SelectResult.expression(POKEMON)

class PokeDexInteractor: ObservableObject {
    @Published var pokemonSpecies: [PokemonSpecy] = []
    @Published var pokemonSelected: [Pokemon] = []
    @Published var pokemon: Pokemon = Pokemon()
    
    @Published var generation: Int = 1
    @Published var totalGeneration: Int = 8
    
    var networkManager = NetworkManager()
    let requestManager = RequestManager()
    let databaseManager = Couchbase(name: "PokeDex")
    
    private var isLoading = false
    
    func increase() {
        if generation < totalGeneration {
            generation += 1
        }
        getAllSpecies()
    }
    
    func decrease() {
        if generation >= 2 {
            generation -= 1
        }
        getAllSpecies()
    }
    
    func createIndex() {
        let name = ValueIndexItem.expression(NAME)
        let liked = ValueIndexItem.expression(LIKED)
        
        databaseManager.createIndex(name: "liked", with: [name, liked])
    }
    
    func get(name: String) {
        guard !isLoading else { return }
        
        if let pokemon = self.databaseManager.queryBy(id: name, type: Pokemon.self) {
            if let _ = pokemon.moves {
                self.pokemon = pokemon
                return
            }
        }
        
        guard !networkManager.offline else { return }
        isLoading = true
        
        requestManager.get(name: name) { pokemon in
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                }
            }
        }
        isLoading = false
    }
    
    func getAllSpecies() {
        guard !isLoading else { return }
        guard !networkManager.offline else { return }
        
        isLoading = true
                
        requestManager.get(generation: generation, totalGeneration: totalGeneration) { generation in
            if let generation = generation {
                if let pokemonSpecies = generation.pokemon_species, pokemonSpecies.count > 0 {
                    DispatchQueue.main.async {
                        self.pokemonSpecies = pokemonSpecies
                    }
                }
            }
        }
        
        isLoading = false
    }
    
    func getAllVoted() {
        if let pokemonSelected = databaseManager.queryAll(type: Pokemon.self) {
            DispatchQueue.main.async {
                self.pokemonSelected = pokemonSelected.compactMap({ pokemon in
                    if pokemon.liked ?? false {
                        return pokemon
                    }
                    return nil
                })
            }
        }
    }
    
    func save(pokemon: Pokemon) {
        pokemon.liked = true
        self.databaseManager.save(pokemon)
    }
    
    func remove(pokemon: Pokemon) {
        self.databaseManager.delete(document: pokemon.document)
    }
}
