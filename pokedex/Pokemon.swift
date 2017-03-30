//
//  Pokemon.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/22/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String
    private var _pokedexId: Int
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    private var _pokemonURL: String!
    private var _pokemonDescURL: String!
    
    
    // Get-ters
    
    var name: String {

        return _name
    }
    
    var pokedexId: Int {

        return _pokedexId
    }
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    
    
    // Init
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_VERSION)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    // Alamofire requests for the detail
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height =  dict["height"] as? String {
                    self._height = height
                }
                
                if let attack =  dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        self._type = type.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                else {
                    self._type = ""
                }
                 print(self._type)
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] {
                    
       
                    if let descriptionURL = descriptions[0]["resource_uri"] {
                        self._pokemonDescURL = URL_BASE + descriptionURL
                        
                        
                        
                    }
                    
                    
                }
                
                
                print(self._attack)
                print(self._defense)
                print(self._height)
                print(self._weight)
                
                //_description: String!
                //_type: String!
                //_nextEvolutionTxt: String!
                
                
            }
            
            completed()
            
        }
    }
    
    
    func downloadPokemonDetailDescription(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonDescURL).responseJSON {
            (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let description = dict["description"] as? String {
                    
                    self._description = description
                    print(description)
                }
            }
            
            completed()
            
        }
    }
    
}
