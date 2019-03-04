//
//  LondonViewController.swift
//  Wheather
//
//  Created by Andrew Zhegalik on 3/1/19.
//  Copyright © 2019 Andrew Zhegalik. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class LondonViewController: UIViewController {
    var temperature: String = "23"
    var humidity: String = "94"
    var descr: String = "Snow"
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var temperatureTextLabel: UILabel!
    @IBOutlet weak var humidityTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=5e156719cb7b0942b54071704ef521fe")
    
        
        request(url!).responseJSON { response in
            guard let jsonArray = response.result.value as? [String: Any] else {
                print("error")
                return
            }
            
            //let weather = jsonArray["weather"] as? [[String: Any]]
            let main = jsonArray["main"] as? [String: Any]

            let weather = jsonArray["weather"] as? [[String: Any]]
            print(weather)
            
            if let weather = weather {
                let main = weather[0]["main"]!
                let description = main as? String
                
                self.descr = description!
            }
            
            if let main = main {
                let temp = main["temp"]!
                let t = temp as? Double
                var te = t!
                te -= 273.15
                self.temperature = String(format: "%2.f", te)
                
                let humidity = main["humidity"]!
                let hum = humidity as? Double
                
                self.humidity = String(hum!)
            }
            
            
            
            DispatchQueue.main.async {
                self.temperatureTextLabel.text = self.temperature + " C"
                self.humidityTextLabel.text = self.humidity + " %"
                self.descriptionTextLabel.text = self.descr
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
