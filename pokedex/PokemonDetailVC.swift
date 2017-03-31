//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/24/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var defenseLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //nameLabel.text = pokemon.name
        
        //pokemonImage.image = UIImage("")
        
        nameLabel.text = "\(pokemon.name.capitalized)"
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = UIImage(named: "\(pokemon.pokedexId)")
        pokedexIDLabel.text = "\(pokemon.pokedexId)"
        
        nextEvoImage.isHidden = true
        
        
        pokemon.downloadPokemonDetail {
            //What ever werun here willl only be called after the download is complete

            
            self.updateUI()
            
            
        }
        
        
        
    }
    
    func updateUI() {
        
        defenseLabel.text = pokemon.defense
        attackLabel.text = pokemon.attack
        weightLabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        
        typeLabel.text = pokemon.type
        
        detailLabel.text = pokemon.description
        
        if pokemon.nextEvolutionName == "" {
            nextEvolutionLabel.text = "No evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: "\(pokemon.nextEvolutionId)")
            nextEvolutionLabel.text = "Next Evolution: #\(pokemon.nextEvolutionId) \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLevel)"
        }
      
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    

}
