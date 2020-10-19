//
//  ViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 05/10/2020.
//

import UIKit

class CurrencyViewController: BaseViewController {
    
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet var currencyLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currency"
        
        convertButton.layer.cornerRadius = 50
        convertButton.layer.borderColor = UIColor.yellow.cgColor
        convertButton.layer.borderWidth = 2
        
        for index in 0..<currencyLabels.count {
            currencyLabels[index].layer.cornerRadius = 20
            currencyLabels[index].layer.borderWidth = 2
            currencyLabels[index].layer.borderColor = UIColor.yellow.cgColor
            
        }
    }
    
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBAction func didTapOnConvertButton() {
        getCurrencyData()
    }
    
    private let networkManager = NetworkManager()
    
    private func getCurrencyData() {
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

