//
//  PokemonDetailsVC.swift
//  pokedex3
//
//  Created by Luka Mitak on 27/03/17.
//  Copyright © 2017 lmitak. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDefenseValue: UILabel!
    @IBOutlet weak var lblPokedexIDValue: UILabel!
    @IBOutlet weak var lblBaseAttackValue: UILabel!
    @IBOutlet weak var lblHeightValue: UILabel!
    @IBOutlet weak var lblWeightValue: UILabel!
    @IBOutlet weak var lblEvolution: UILabel!
    @IBOutlet weak var imgEvolutionCurrent: UIImageView!
    @IBOutlet weak var imgEvolutionNext: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        imgPokemon.image = img
        imgEvolutionCurrent.image = img
        lblName.text = pokemon.name.capitalized
        lblPokedexIDValue.text = "\(pokemon.pokedexId)"

        pokemon.downloadPokemonDetails {
            //After download is complete
            
            self.updateUI()
            
            
        }
    }
    
    func updateUI() {
        
        lblType.text = pokemon.type
        lblWeightValue.text = pokemon.weight
        lblHeightValue.text = pokemon.height
        lblBaseAttackValue.text = pokemon.attack
        lblDefenseValue.text = pokemon.defense
        lblDescription.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            lblEvolution.text = "No Evolutions"
            imgEvolutionNext.isHidden = true
        } else {
            imgEvolutionNext.isHidden = false
            imgEvolutionNext.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            lblEvolution.text = str
        }
    }

    
    @IBAction func onBackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
