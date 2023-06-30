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
        
        setUp()
    }

    private func setUp() {
        // Initial Checks
        labelEmoji.isUserInteractionEnabled = true

        // Initial Actions
        if let stringContent = UserDefaults.standard.value(forKey: "ContentOfTheTextfield") as? String {
            textfield.text = stringContent
        }
        
        labelEmoji.text = (textfield.text == "" ? "💩" : "❤️")
        
        instructions.text = "❤️ or 💩"
        textfield.placeholder = "Introduzca algo para ❤️ o nada para 💩"
        clearCacheButton.setTitle("Clear Cache", for: .normal)
        
        // GestureResponder
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchLabel))
        labelEmoji.addGestureRecognizer(tapGesture)
        
        // Delegate Textfield
        textfield.delegate = self
    }
    
    // Method that save the set of label
    private func setLabel( example: String?) {
        guard let example else { return }
        labelEmoji.text = (example == "" ? "💩" : "❤️")
        UserDefaults.standard.set(example, forKey: "ContentOfTheTextfield")
    }
    
    
    // Method that reply GestureResponder and navigate go to the SecondVC
    @objc func touchLabel() {
        let secondVC = SecondViewController()
        secondVC.emoji = labelEmoji.text
        self.present(secondVC, animated: true, completion: nil)
    }
    
    @IBAction func ClearCacheAction(_ sender: Any) {
        textfield.text = ""
        UserDefaults.standard.removeObject(forKey: "ContentOfTheTextfield")
        setLabel(example: textfield.text)
    }
    
}

// Textfield Delegate Methods
extension PrincipalViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newString = textfield.text ?? ""

                if string.isEmpty {
                    newString = String(newString.dropLast(1))
                } else {
                    newString = "\(newString)\(string)"
                }
        
        setLabel(example: newString)
        
        return true
    }
}
