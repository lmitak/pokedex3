//
//  PokeCell.swift
//  pokedex3
//
//  Created by Luka Mitak on 27/03/17.
//  Copyright © 2017 lmitak. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon){
        
        self.pokemon = pokemon
        
        lblName.text = self.pokemon.name.capitalized
        imgThumb.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
    
}
