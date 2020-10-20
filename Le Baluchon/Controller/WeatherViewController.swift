//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 12/10/2020.
//

import UIKit

class WeatherViewController: BaseViewController {

    @IBOutlet var citiesButton: [UIButton]!
    @IBOutlet var citiesLabel: [UILabel]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Weather"
       
//        for index in 0..<citiesButton.count {
//            citiesButton[index].layer.cornerRadius = 30
//            citiesButton[index].layer.borderWidth = 2
//            citiesButton[index].layer.borderColor = UIColor.orange.cgColor
//
//
//        }
    }
  
    @IBAction func TapCitiesButton(_ sender: Any) {
        
    }
    
  
}
