//
//  ViewControllerExtension.swift
//  MEX_Assignment
//
//  Created by Shephali Srivas on 29/05/22.
//

import UIKit

extension UIViewController {
    func alertWithInputField(title:String? = nil,
                             message:String? = nil,
                             actionHandler: ((_ text: String?) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter text..."
        }
        alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
