//
//  ViewController.swift
//  Aurora_Predictor
//
//  Created by student1 on 2/10/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, ForecastController {
    
    @IBOutlet var forecastLabel: UILabel!
    
    var forecasts: [Forecast]?
    
    func forecastsAvailable(_ forecasts: [Forecast]) {
        self.forecasts = forecasts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
    
        let forecast = forecasts![indexPath.row]
        
        cell!.textLabel!.text = forecasts![indexPath.row].description
        
        // Observed forecasts are ones that have already happened, display in gray
        if forecast.observed == Forecast.Observed.Observed {
            cell?.backgroundColor = UIColor.gray
        } else {
            cell?.backgroundColor = UIColor.white
        }
        
        // Interesting kp values in purple 
        if forecast.kp >= 4 {
            cell?.textLabel?.textColor = UIColor.purple
            
        } else {
            cell?.textLabel?.textColor = UIColor.black
        }
        
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let forecasts = forecasts {
            return forecasts.count
        }
        
        return 0
        
    }
    
}




