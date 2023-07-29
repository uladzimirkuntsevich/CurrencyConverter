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
    
    struct Json: Codable {
//        var meta: LastUpdate
        var data: Data
    }
    
//    struct LastUpdate: Codable {
//        var last_updated_at: String
//    }
    
    struct Data: Codable {
        var CAD: Double
//        var EUR: Double
//        var BYN: Double
    }
    
    
    var fetchedData: Json?
    
    var baseCurrency: String = "EUR"
    var targetCurrency: String = "CAD"
    var conversionRate: Double?

    
    
    private var apiKey = "qRz8ynlhgeGTlou1uK4cyv09CyuiZo7SNpu5bVa7"
    private var baseUrl = "https://api.freecurrencyapi.com"
    private var latetstEndpoint = "/v1/latest"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addElementConstraints()
        addStyles()
        setupActions()
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
    
    func setupActions() {
        textField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
    }
    
    @objc func textFieldEditing() {
        fetchData { (data, error) in
            if let error = error {
                print ("Error: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "There was a problem fetching the data.")
                }
            } else if let data = data {
                DispatchQueue.main.async {
                    self.fetchedData = data
                    self.conversionRate = self.fetchedData?.data.CAD
                }
            }
        }
        if let text = textField.text, let value = Double(text), let targetValue = conversionRate {
            labelField.text = "\(round(value * targetValue * 100) / 100)"
        }
    }
    
    
    func fetchData (completion: @escaping (Json?, Error?) -> Void) {
        
        let urlWithParameters = baseUrl + latetstEndpoint + "?apikey=\(apiKey)&base_currency=\(baseCurrency )&currencies=\(targetCurrency)"
        
        guard let url = URL(string: urlWithParameters) else {
            print("No URL has been specified")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dataObject = try decoder.decode(Json.self, from: data)
                    completion(dataObject, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    

}

