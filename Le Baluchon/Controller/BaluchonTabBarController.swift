//
//  BaluchonTabBarController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 12/10/2020.
//

import UIKit

class BaluchonTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItens()
       
    }
    
    private let tabBarTitles: [String] = [
        "Currency",
        "Weather",
        "Translate"
    ]
    
    
    private func setupTabBarItens() {
        
        
        guard
            let itens = tabBar.items
        else {
            print("Could not setup tab bar itens")
            return
        }
        
        
        for (index, iten) in itens.enumerated() where index < tabBarTitles.count {
            iten.title = tabBarTitles[index]
        }

    }


}
