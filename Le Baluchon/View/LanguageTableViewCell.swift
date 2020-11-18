//
//  LanguageTableViewCell.swift
//  Le Baluchon
//
//  Created by Fabrice Mourou on 13/11/2020.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

  
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    

    
    func setLanguage(languages: Language) {
        flagImageView.image = languages.image
        languageLabel.text = languages.title
        
    }
    
    
    
    
    
    
}
