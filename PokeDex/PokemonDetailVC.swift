//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Ben on 5/5/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!

    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namelbl.text = pokemon.name.capitalized
        
        let image = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = image
        currentEvoImage.image  = image
        
        pokemon.downloadPokemonDetails {
        self.pokedexIDLabel.text = String(self.pokemon.pokedexID)
            
            print("Did arrive here")
            // Whatever we write will only be called when the network call is complete
            self.updateUI()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" {
            evoLabel.text = "No further evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
            let str = "Next evolution: \(pokemon.nextEvolutionName) LVL \(pokemon.nextEvolutionLvl)"
            evoLabel.text = str
        }
        
    }
 
}
