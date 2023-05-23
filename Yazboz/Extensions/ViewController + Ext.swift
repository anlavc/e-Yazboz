//
//  ViewController + Ext.swift
//  Yazboz
//
//  Created by Anıl AVCI on 20.05.2023.
//

import UIKit

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okButtonTitle: String = "Tamam", cancelButtonTitle: String = "İptal", okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okAction?()
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelAction?()
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func showOkAlert(title: String, message: String, buttonTitle: String = "Tamam") {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
}

