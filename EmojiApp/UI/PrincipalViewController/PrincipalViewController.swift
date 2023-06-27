//
//  PrincipalViewController.swift
//  EmojiApp
//
//  Created by Alejandro Rodríguez Cañete on 26/6/23.
//

import UIKit

class PrincipalViewController: UIViewController {

    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var labelEmoji: UILabel!
    @IBOutlet weak var clearCacheButton: UIButton!
    
    var emoji = ["💩","❤️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Checks
        labelEmoji.isUserInteractionEnabled = true

        // Initial Actions
        let contentTextfield = UserDefaults.standard.value(forKey: "ContentOfTheTextfield")
        
        if let stringContent = contentTextfield as? String {
            textfield.text = stringContent
        }
        
        let checkContent = textfield.text
        
        if checkContent != "" {
            labelEmoji.text = "\(emoji[1])"
        } else {
            labelEmoji.text = "\(emoji[0])"
        }
        
        instructions.text = "❤️ or 💩"
        textfield.placeholder = "Introduzca algo para ❤️ o nada para 💩"
        clearCacheButton.setTitle("Clear Cache", for: .normal)
        
        // GestureResponder
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TouchLabel))
        labelEmoji.addGestureRecognizer(tapGesture)
        
        // Delegate Textfield
        textfield.delegate = self
    }

    // Method that reply GestureResponder
    @objc func TouchLabel() {
        let content = textfield.text
        let secondVC = SecondViewController()

        if content == "" {
            secondVC.emoji = "\(emoji[0])"
            self.present(secondVC, animated: true, completion: nil)
        } else {
            secondVC.emoji = "\(emoji[1])"
            self.present(secondVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func ClearCacheAction(_ sender: Any) {
        textfield.text = ""
        UserDefaults.standard.removeObject(forKey: "ContentOfTheTextfield") 
    }
    
}

// Textfield Delegate Methods
extension PrincipalViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let content = textField.text
        
        UserDefaults.standard.set(content, forKey: "ContentOfTheTextfield")
        
        let checkContent = textfield.text
        
        if checkContent != "" {
            labelEmoji.text = "\(emoji[1])"
        } else {
            labelEmoji.text = "\(emoji[0])"
        }
    }
}
