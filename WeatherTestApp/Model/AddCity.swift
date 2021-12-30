//
//  AddCity.swift
//  WeatherTestApp
//
//  Created by Roman Korobskoy on 31.12.2021.
//

import UIKit

extension UIViewController {
    
    func alertAddCity(name: String, placeholder: String, completionHandler: @escaping(String) -> Void) {
        
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { action in
            let text = alert.textFields?.first
            guard let text = text?.text else { return }
            completionHandler(text)
        }
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in }
        alert.addAction(alertOk)
        alert.addAction(alertCancel)
        
        present(alert, animated: true, completion: nil)
    }
}
