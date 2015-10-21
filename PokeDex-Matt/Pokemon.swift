//
//  Pokemon.swift
//  PokeDex-Matt
//
//  Created by Matthew Wells on 2015-10-20.
//  Copyright © 2015 Matthew Wells. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
        
        return _description
        }
    }
    
    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
        return _type
        }
    }
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
        return _defense
        }
    }
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
        
        return _height
        }
    }
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
        
        return _weight
        }
    }
    var attack: String {
        get {
            if _attack == nil {
                _attack = ""
            }
        
        return _attack
        }
    }
    var nextEvolutionTxt: String {
        get {
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
        
        return _nextEvolutionTxt
        }
    }
    
    var nextEvolutionID: String {
        get {
            if _nextEvolutionID == nil {
                _nextEvolutionID = ""
            }
            
            return _nextEvolutionID
        }
    }
    var nextEvolutionLvl: String {
        get {
            if _nextEvolutionLvl == nil {
                _nextEvolutionLvl = ""
            }
            
            return _nextEvolutionLvl
        }
    }
    
    
    
    
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    // grab the first type
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    // if more than one type, go through each one and grab them
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                               self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    // if no type, print nothing
                    self._type = ""
                }
                print(self._type)

                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count  > 0 {
                
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let desResult = response.result
                            
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        // mega is not found (not supported in this API)
                        if to.rangeOfString("Mega") == nil {
                        
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionID = num
                                self._nextEvolutionTxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLvl = "\(lvl)"
                                }
                                
                              //  print(self._nextEvolutionID)
                             //   print(self._nextEvolutionTxt)
                            //    print(self._nextEvolutionLvl)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

