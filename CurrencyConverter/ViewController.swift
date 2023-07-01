//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Владимир Кунцевич on 01.07.23.
//

import UIKit

class ViewController: UIViewController {
    
    var textField = UITextField()
    var labelField = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addElementConstraints()
        addStyles()
    }
    
    func addSubviews() {
        [textField, labelField].forEach({view.addSubview($0)})
        [textField, labelField].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    func addElementConstraints() {
        view.addConstraints([
            //MARK: adding constraints for textField
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //MARK: adding constraints for labelField
            labelField.topAnchor.constraint(equalTo: textField.topAnchor, constant: 100),
            labelField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
 
            
        ])
    }
    
    
    func addStyles(){
        textField.placeholder = "0.00"
        labelField.text = "0.00"
        [textField, labelField].forEach({$0.layer.borderWidth = 1})
        [textField, labelField].forEach({$0.layer.cornerRadius = 5})
        [textField, labelField].forEach({$0.layer.borderColor = UIColor.black.cgColor})
    }

}

