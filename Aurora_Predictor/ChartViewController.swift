//
//  ChartViewController.swift
//  Aurora_Predictor
//
//  Created by student1 on 2/11/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ForecastController {
    var forecasts: [Forecast]?
    
    
    @IBOutlet var chartView: LineChartView!
//    var forecasts: [Forecast]?
    
    func forecastsAvailable(_ forecast: [Forecast]) {
        print("forecasts here")
        
        self.forecasts = forecast
        
        DispatchQueue.main.async {
            self.drawChart()
        }
    }
    
    
    
    func drawChart() {
        
        if let fc = forecasts {
            
            let dataSetValues = fc.enumerated().map({ (arg: (offset: Int, element: Forecast)) -> ChartDataEntry in let (index, forecast) = arg; return ChartDataEntry(x: Double(index), y: Double(forecast.kp)) } )
            let dataSet = LineChartDataSet(values: dataSetValues, label: "date")
            let data = LineChartData(dataSet: dataSet)
            chartView.data = data
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        
        
        let e1 = ChartDataEntry(x: 1.0, y: 2.0)
        let e2 = ChartDataEntry(x: 5.0, y: 7.0)
        let e3 = ChartDataEntry(x: 8.4, y: 10.0)
        let dataset = LineChartDataSet(values: [e1, e2, e3], label: "kp")
        
        let data = LineChartData(dataSet: dataset)
        
        chartView.data = data
    }
    
}
