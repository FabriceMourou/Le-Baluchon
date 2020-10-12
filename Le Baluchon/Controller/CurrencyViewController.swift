//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 05/10/2020.
//

import UIKit

class CurrencyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currency Converter"
    }

    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBAction func didTapOnConvertButton() {
        getCurrencydata()
    }
    
    private let networkManager = NetworkManager()
    
    private func getCurrencydata() {
        networkManager.fetch(url: URL(string: "http://data.fixer.io/api/latest?access_key=3d2ba3bcfe5a29250698c07e1ac37680")!) { (result: Result<CurrencyResponse, NetworkManagerError>) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Success")

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

