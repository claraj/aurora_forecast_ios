//
//  Forecast.swift
//  Aurora_Predictor
//
//  Created by student1 on 2/10/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

class Forecast {
    let date: Date
    let kp: Int
    let observed: Observed
    let noaaScale: String!
    
    enum Observed: String {
        case Observed = "observed"
        case Estimated = "estimated"
        case Predicted = "predicted"
    }
    
    var dateFormatter: DateFormatter = {
       let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"    //example "2019-02-04 15:00:00"
        return df
    }()
    
    
    init!(data: [String?]) {
    
        if let date = data[0], let dateFromString: Date = dateFormatter.date(from: date) {
            self.date = dateFromString
        } else {
            return nil
        }
        
        if let kp_string = data[1], let kp = Int(kp_string) {
            self.kp = kp
        } else {
            return nil
        }

        if let ob = data[2], let observed = Observed(rawValue: ob) {
            self.observed = observed
        } else {
            return nil
        }
        
        noaaScale = data[3]
        
    }

    
    public var description: String {
        return "\(date) \(kp) \(observed) \(noaaScale)"
    }
}


