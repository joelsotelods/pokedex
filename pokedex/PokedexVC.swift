//
//  PokedexVC.swift
//  pokedex
//
//  Created by Joel Sotelo Llamas on 3/22/17.
//  Copyright © 2017 joel sotelo. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    @IBOutlet weak var collection: UICollectionView! 
    
    var pokemons = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
        initAudio()
        
        //let charmander = Pokemon(name: "Charmander", pokedexId: 4)
        //print(charmander.name)
        
    }
    
    
    @IBAction func musicButtonPreessed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: ".mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
            
        }
        
    }
    
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows) //print the readed rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemons.append(poke)
            }
            
        } catch let err as NSError {
                print(err.debugDescription)
            
        }
        
    }
    
    
    
    //Functions necessary for the Collection View
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            
            
            let poke = pokemons[indexPath.row]
            cell.configureCell(pokemon: poke)
            
            //let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row+1)
            //cell.configureCell(pokemon: pokemon)
            
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //this comes from UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }

    //end
    
    

}

