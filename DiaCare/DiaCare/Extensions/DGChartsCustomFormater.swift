//
//  DGChartsCustomFormater.swift
//  DiaCare
//
//  Created by Кирилл Щёлоков on 08.05.2024.
//

import Foundation
import DGCharts

class CustomDataFormater: ValueFormatter {
    func stringForValue(
        _ value: Double,
        entry: DGCharts.ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: DGCharts.ViewPortHandler?
    ) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        guard let result = numberFormatter.string(from: NSNumber(value: value)) else { return value.description}
        return result
    }
}
