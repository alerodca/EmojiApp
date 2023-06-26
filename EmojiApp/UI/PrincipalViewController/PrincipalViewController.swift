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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Checks
        labelEmoji.isUserInteractionEnabled = true

        let contenidoTextfield = UserDefaults.standard.value(forKey: "ContentOfTheTextfield")
        
        if let cadenacontexto = contenidoTextfield as? String {
            textfield.text = cadenacontexto
        }
        
        let comprobarContenido = CheckContent(content: contenidoTextfield as? String)
        
        if comprobarContenido {
            labelEmoji.text = "❤️"
        } else {
            labelEmoji.text = "💩"
        }
        
        
        instructions.text = "❤️ or 💩"
        textfield.placeholder = "Introduzca algo para ❤️ o nada para 💩"
        clearCacheButton.setTitle("Clear Cache", for: .normal)
        
        // GestureResponder
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(etiquetaTocada))
        labelEmoji.addGestureRecognizer(tapGesture)
        
        // Delegate Textfield
        textfield.delegate = self
    }

    // Method that reply GestureResponder
    @objc func etiquetaTocada() {
        let content = textfield.text
        
        if content == "" {
            navigationController?.pushViewController(ShitViewController(), animated: true)
        } else {
            navigationController?.pushViewController(HeartViewController(), animated: true)
        }
    }
    
    // Function that check the content of the textfield
    func CheckContent(content: String?) -> Bool {
        if content == "" {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func ClearCacheAction(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "ContentOfTheTextfield")
        textfield.text = ""
    }
    
}

// Textfield Delegate Methods
extension PrincipalViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let content = textField.text
        
        UserDefaults.standard.set(content, forKey: "ContentOfTheTextfield")
        
        let callFunction = CheckContent(content: content)
        
        if callFunction {
            labelEmoji.text = "❤️"
        } else {
            labelEmoji.text = "💩"
        }
    }
}
