//
//  MoscowViewController.swift
//  Wheather
//
//  Created by Andrew Zhegalik on 3/4/19.
//  Copyright © 2019 Andrew Zhegalik. All rights reserved.
//

import UIKit
import Alamofire

class MoscowViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var temperatureTextLabel: UILabel!
    @IBOutlet weak var humidityTextLabel: UILabel!
    
    
    var temperature: String = ""
    var humidity: String = ""
    var descr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=5e156719cb7b0942b54071704ef521fe")
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
