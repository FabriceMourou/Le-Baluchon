//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 05/10/2020.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        getCurrencydata()
    }

    
    @IBOutlet weak var rateLabel: UILabel!
    
    private let networkManager = NetworkManager()
    
    func getCurrencydata() {
        networkManager.fetch(url: URL(string: "http://data.fixer.io/api/latest?access_key=3d2ba3bcfe5a29250698c07e1ac37680")!) { (result: Result<CurrencyResponse, NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("SUccess")

                    let euroToUsdRate = response.rates["USD"]!
                    
                    print(euroToUsdRate)
                    
                    self.rateLabel.text = euroToUsdRate.description
                case .failure:
                    print("failure")
                }
            }
            
        }
    }

}

