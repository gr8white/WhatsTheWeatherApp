//
//  ViewController.swift
//  What's The Weather
//
//  Created by Derrick White on 12/31/18.
//  Copyright © 2018 Derrick White. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func getWeather(_ sender: Any) {
        let url = URL(string: "https://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")!
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
            data, response, error in
            
            var message = ""
            
            if let error = error {
                
                print(error)
                
            } else {
                
                if let unwrappedData = data {
                    
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                print(message)
                            }
                        }
                    }
                }
            }
            
            if message == "" {
                
                message = "The weather there coudn't be found. Please try again."
                
            }
            
            DispatchQueue.main.sync(execute: {
                
                self.resultLabel.text = message
                
            })
            
        }
        
        task.resume()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }


}


