//
//  PortoEntity.swift
//  Case3-MobileAppPortfolio
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

struct ChartData: Codable {
    let label: String
    let percentage: String
    let data: [Transaction]
}

struct Transaction: Codable {
    let trx_date: String
    let nominal: Int
}

struct LineChartData: Codable {
    let month: [Int]
}

enum ChartDataType: Codable {
    case chartData([ChartData])
    case lineChartData(LineChartData)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let chartData = try? container.decode([ChartData].self) {
            self = .chartData(chartData)
        } else if let lineChartData = try? container.decode(LineChartData.self) {
            self = .lineChartData(lineChartData)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid data")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .chartData(let chartData):
            try container.encode(chartData)
        case .lineChartData(let lineChartData):
            try container.encode(lineChartData)
        }
    }
}

struct Chart: Codable {
    let type: String
    let data: ChartDataType
}

struct ChartsData: Codable {
    let charts: [Chart]
}
