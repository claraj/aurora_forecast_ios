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
    //    @IBOutlet var chartView: LineChartView!
//    var forecasts: [Forecast]?
    
    func forecastsAvailable(_ forecast: [Forecast]) {
        print("forecasts here")
        
        self.forecasts = forecast
        
        DispatchQueue.main.async {
            self.drawChart()
        }
    }
    
    
    
    func drawChart() {
        
        // TODO dates on x axis
        
        let xAxisFormatter = ChartXAxisFormatter()
        
        
        if let fc = forecasts {
            
            let date = Date()
            print(date.timeIntervalSince1970)
            
        
            let dataSetValues: [ChartDataEntry] = fc.map( { (forecast: Forecast) -> ChartDataEntry in
                return ChartDataEntry(x: Double(forecast.date.timeIntervalSince1970), y: Double(forecast.kp))
            })
            
            
            
            let dataSet = LineChartDataSet(values: dataSetValues, label: "kp")
            
            dataSet.mode = .horizontalBezier
            
            dataSet.circleRadius = 3
            
            let now = Date()
            
            // TODO timezones?? Assume date is UTC?
            
//            let colorHex = [ "021d65",
//             "0c0276",
//             "0x3e0287",
//             "0x7d0298",
//             "0xaa018b",
//            "0xbb0156",
//             "0xcc0114",
//             "0xdd3d01",
//             "0xee9700",
//             "0xffff00"
//             ]
//
            
            let colorMap = [
                0: UIColor.gray,
                1: UIColor.lightGray,
                2: UIColor.green,
                3: UIColor.blue,
                4: UIColor.cyan,
                5: UIColor.purple,
                6: UIColor.magenta,
                7: UIColor.red,
                8: UIColor.orange,
                9: UIColor.yellow
            ]
            
            
            // Red if observed, green after today
//            let colors = fc.map( { (fc: Forecast) -> UIColor in return  fc.observed == Forecast.Observed.Observed  ? UIColor.green : UIColor.red } )
//
              let colors = fc.map( { $0.observed == Forecast.Observed.Observed  ? UIColor.blue : UIColor.green } )
            
            //let colors = fc.map( { colorMap[$0.kp] } )
            
            dataSet.circleColors = colors
            
            let data = LineChartData(dataSet: dataSet)
            
            
            chartView.xAxis.valueFormatter = xAxisFormatter
            chartView.xAxis.labelRotationAngle = 90
            chartView.leftAxis.axisMinimum = 0.0
            chartView.leftAxis.axisMaximum = 9.0
            
            chartView.rightAxis.enabled = false
            
            chartView.data = data
            
            chartView.notifyDataSetChanged()
            chartView.backgroundColor = UIColor.darkGray
            chartView.fitScreen()
            
            
        }
        
    }
    
   
    class ChartXAxisFormatter: IAxisValueFormatter {
        
        let chartXAxisDateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "M/d"  // 2/4  month/day
            return df
        }()
        
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // value is a unix timestamp
            let date = Date(timeIntervalSince1970: value)
            print("\(date), \(value)")
            let formattedDate = chartXAxisDateFormatter.string(from: date)
            print(formattedDate)
            return formattedDate
        }
    }
    
    
    override func viewDidLoad() {
        
        
        // Experimenting with Charts....
//        let e1 = ChartDataEntry(x: 1.0, y: 2.0)
//        let e2 = ChartDataEntry(x: 5.0, y: 7.0)
//        let e3 = ChartDataEntry(x: 8.4, y: 10.0)
//        let dataset = LineChartDataSet(values: [e1, e2, e3], label: "kp")
//
//        let data = LineChartData(dataSet: dataset)
//
//        chartView.data = data
    }
    
}
