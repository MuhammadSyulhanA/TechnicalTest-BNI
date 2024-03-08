//
//  PortoInteractor.swift
//  Case3-MobileAppPortfolio
//
//  Created by M. Syulhan Al Ghofany on 08/03/24.
//

import Foundation

class PortfolioDataManager {
    static let shared = PortfolioDataManager()
    
    private var chartsData: ChartsData?
    
    private init() {}
    
    func loadPortfolioData() {
        let jsonString = """
        {
            "charts": [
                {
                    "type": "donutChart",
                    "data": [
                        {
                            "label": "Tarik Tunai",
                            "percentage": "55",
                            "data": [
                                {
                                    "trx_date": "21/01/2023",
                                    "nominal": 1000000
                                },
                                {
                                    "trx_date": "20/01/2023",
                                    "nominal": 500000
                                },
                                {
                                    "trx_date": "19/01/2023",
                                    "nominal": 1000000
                                }
                            ]
                        },
                        {
                            "label": "QRIS Payment",
                            "percentage": "31",
                            "data": [
                                {
                                    "trx_date": "21/01/2023",
                                    "nominal": 159000
                                },
                                {
                                    "trx_date": "20/01/2023",
                                    "nominal": 35000
                                },
                                {
                                    "trx_date": "19/01/2023",
                                    "nominal": 1500
                                }
                            ]
                        },
                        {
                            "label": "Topup Gopay",
                            "percentage": "7.7",
                            "data": [
                                {
                                    "trx_date": "21/01/2023",
                                    "nominal": 200000
                                },
                                {
                                    "trx_date": "20/01/2023",
                                    "nominal": 195000
                                },
                                {
                                    "trx_date": "19/01/2023",
                                    "nominal": 5000000
                                }
                            ]
                        },
                        {
                            "label": "Lainnya",
                            "percentage": "6.3",
                            "data": [
                                {
                                    "trx_date": "21/01/2023",
                                    "nominal": 1000000
                                },
                                {
                                    "trx_date": "20/01/2023",
                                    "nominal": 500000
                                },
                                {
                                    "trx_date": "19/01/2023",
                                    "nominal": 1000000
                                }
                            ]
                        }
                    ]
                },
                {
                    "type": "lineChart",
                    "data": {
                        "month": [
                            3,
                            7,
                            8,
                            10,
                            5,
                            10,
                            1,
                            3,
                            5,
                            10,
                            7,
                            7
                        ]
                    }
                }
            ]
        }
        """
        
        // Decode JSON
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                //                let chartsData = try JSONDecoder().decode(ChartsData.self, from: jsonData)
                //
                //                for chart in chartsData.charts {
                //                    switch chart.data {
                //                    case .chartData(let chartData):
                //                        print("Chart type: \(chart.type)")
                //                        for data in chartData {
                //                            print("Label: \(data.label)")
                //                            print("Percentage: \(data.percentage)")
                //                            print("Transactions:")
                //                            for transaction in data.data {
                //                                print("   Date: \(transaction.trx_date), Nominal: \(transaction.nominal)")
                //                            }
                //                            print("")
                //                        }
                //                    case .lineChartData(let lineChartData):
                //                        print("Chart type: \(chart.type)")
                //                        print("Line Chart Data:")
                //                        print(lineChartData)
                //                    }
                //                }
                chartsData = try JSONDecoder().decode(ChartsData.self, from: jsonData)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func getChartsData() -> ChartsData? {
        return chartsData
    }
}
