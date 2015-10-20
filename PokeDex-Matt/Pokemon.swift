//
//  Pokemon.swift
//  PokeDex-Matt
//
//  Created by Matthew Wells on 2015-10-20.
//  Copyright © 2015 Matthew Wells. All rights reserved.
//

import Foundation


class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    
}