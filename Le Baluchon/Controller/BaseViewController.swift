//
//  BaseViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 12/10/2020.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        let closingKeyboardGestureRecogniyer = UITapGestureRecognizer(
            target: self,
            action: #selector(closeKeyboard)
        )
        
        view.addGestureRecognizer(closingKeyboardGestureRecogniyer)
        
    }
    
    
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }


}
