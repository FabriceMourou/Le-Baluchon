//
//  BaluchonNavigationController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 12/10/2020.
//

import UIKit


class BaluchonNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.prefersLargeTitles = true
    
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        setFont()

        
        navigationBar.largeTitleTextAttributes = textAttributes
    }
    
    func setFont()
        {
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 20)!]
    }
}
