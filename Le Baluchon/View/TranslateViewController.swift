//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 13/10/2020.
//

import UIKit

class TranslateViewController: BaseViewController{
    
    
    
    @IBOutlet weak var topTextView: UITextView!
    @IBOutlet weak var bottomTextView: UITextView!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Translate"
        makeroundedCorners()
    }
    
    private func makeroundedCorners() {
        topTextView.layer.cornerRadius = 10
        topButton.layer.cornerRadius = 15
        
        bottomTextView.layer.cornerRadius = 10
        bottomButton.layer.cornerRadius = 15
        
        
    }
    
}
