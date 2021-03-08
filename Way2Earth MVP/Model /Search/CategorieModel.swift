//
//  CategorieModel.swift
//  Way2Earth MVP
//
//  Created by Alan Bahena on 3/5/21.
//  Copyright © 2021 Alan Bahena. All rights reserved.
//

import UIKit

struct Categorie {
    
    var image: UIImage
    var categoryText: String
    
    static func fetchCategories() -> [Categorie] {
        
        var categories = [Categorie]()
        
        let cat1 = Categorie(image: UIImage(named: "Earth")!, categoryText: "Earth")
        let cat2 = Categorie(image: UIImage(named: "Traveling")!, categoryText: "Traveling")
        let cat3 = Categorie(image: UIImage(named: "Culture")!, categoryText: "Culture")
        let cat4 = Categorie(image: UIImage(named: "Food")!, categoryText: "Food")
        let cat5 = Categorie(image: UIImage(named: "Climate")!, categoryText: "Climate Change")
        let cat6 = Categorie(image: UIImage(named: "Art")!, categoryText: "Art")
        let cat7 = Categorie(image: UIImage(named: "Stories")!, categoryText: "Stories")
        let cat8 = Categorie(image: UIImage(named: "Science")!, categoryText: "Science")
        let cat9 = Categorie(image: UIImage(named: "Meditation")!, categoryText: "Meditation")
        let cat10 = Categorie(image: UIImage(named: "Yoga")!, categoryText: "Yoga")
        
        categories.append(cat1)
        categories.append(cat2)
        categories.append(cat3)
        categories.append(cat4)
        categories.append(cat5)
        categories.append(cat6)
        categories.append(cat7)
        categories.append(cat8)
        categories.append(cat9)
        categories.append(cat10)
        
        return categories
    }
}
