//
//  ForecastFetcher.swift
//  Aurora_Predictor
//
//  Created by student1 on 2/10/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

let url_str = "https://services.swpc.noaa.gov/products/noaa-planetary-k-index-forecast.json"

class ForecastFetcher {
    
    
    func fetchFor(_ forecastControllers: [ForecastController]) {
    
        // do thing, set value in the wantForecast
        
        getAuroraForecast() { (forecasts, error) in
            if let error = error {
                print("error \(error)")
            } else {
                if let fc = forecasts {
                    forecastControllers.forEach( { $0.forecastsAvailable(fc) })
                }
            }
        }
    }
    
    
    func getAuroraForecast(completion: @escaping (_ forecasts: [Forecast]?, _ error: Error?) -> Void )  {
        
        let url = URL(string: url_str)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {data, response, error in
            
            if (error != nil) {
                return completion(nil, error)
            }
            
            // TODO return error if can't parse response
            if let data = data {
                let forecasts = self.parseJson(data: data)
                return completion(forecasts, nil)
            } else {
                return completion(nil, nil)  // but with actual error
            }
        }
        
        task.resume()  // Starts the request
    }
    
    
    // A synchronous function
    func parseJson(data: Data) -> [Forecast] {
        
        let decoder = JSONDecoder()
        
        let json = try! decoder.decode([[String?]].self, from: data)
        let forecasts = json.compactMap({ Forecast(data: $0) })
        return forecasts
        
    }
}

