//
//  WantForecast.swift
//  Aurora_Predictor
//
//  Created by student1 on 2/11/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

protocol ForecastController {
    func forecastsAvailable(_ forecast: [Forecast]) -> Void
}
