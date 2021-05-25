//
//  PokemonTypeUIView.swift
//  Core
//
//  Created by Administrator on 5/24/21.
//

import SwiftUI

enum PokemonType: String, CaseIterable {
    case poison
    case grass
    case fire
    case water
    case bug
    case normal
    case flying
    case ground
    case psychic
}

struct PokemonTypeUIView: View {
    
    var type: String = ""
    
    func getBackground(type: String) -> Color {
        let pokemonType = PokemonType(rawValue: type)
        
        switch pokemonType {
        case .poison:
            return .purple
        case .grass:
            return .green
        case .fire:
            return .red
        case .water:
            return .blue
        case .bug:
            return .green
        case .flying:
            return .yellow
        case .ground:
            return Color(white: 0).fromHex(hex: 0x6F4E37)
        case .psychic:
            return .pink
        default:
            return .gray
        }
    }
    
    var body: some View {
        TitleRowUIView(
            subheadline: type.capitalized,
            subheadlineColor: .white,
            background: getBackground(type: type)
        )
    }
}

struct PokemonTypeUIView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeUIView()
    }
}
