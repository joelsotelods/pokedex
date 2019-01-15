//
//  PokeCell.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/22/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text = "#\(self.pokemon.pokedexId) \(self.pokemon.name.capitalized)"
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
    
}
