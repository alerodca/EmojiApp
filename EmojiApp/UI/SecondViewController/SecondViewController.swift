//
//  SecondViewController.swift
//  EmojiApp
//
//  Created by Alejandro Rodríguez Cañete on 27/6/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var labelSecondViewController: UILabel!
    
    var emoji: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelSecondViewController.text = emoji
    }

}
