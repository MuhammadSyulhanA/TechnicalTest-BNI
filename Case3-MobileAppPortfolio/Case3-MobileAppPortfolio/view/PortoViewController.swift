//
//  PortoViewController.swift
//  Case3-MobileAppPortfolio
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

import UIKit
import SnapKit
import Charts

class PortoViewController: UIViewController {
    
    let pieChartView = PieChartView()
    let lineChartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieChart()
        setupLineChart()
        
        pieChartView.delegate = self
        
        PortfolioDataManager.shared.loadPortfolioData()
        displayPortfolioData()
        
        view.backgroundColor = .white
    }
    
    func setupPieChart() {
        view.addSubview(pieChartView)
        pieChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.height.equalTo(300)
        }
    }
    
    func setupLineChart() {
        view.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(300)
        }
    }
    
    func setupPieChartData(data: [ChartData]) {
        var entries: [PieChartDataEntry] = []
        for chartData in data {
            guard let percentage = Double(chartData.percentage) else { continue }
            entries.append(PieChartDataEntry(value: percentage, label: chartData.label))
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "Pie Chart")
        let colors = ChartColorTemplates.joyful()
        dataSet.colors = colors
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
        pieChartView.chartDescription.text = "Portfolio Data"
        pieChartView.notifyDataSetChanged()
    }
    
    func setupLineChartData(data: LineChartData) {
        var entries: [ChartDataEntry] = []
        for (index, value) in data.month.enumerated() {
            entries.append(ChartDataEntry(x: Double(index), y: Double(value)))
        }
        
        let dataSet = LineChartDataSet(entries: entries, label: "Month Data")
        dataSet.colors = [.blue]
        
        lineChartView.chartDescription.text = "Monthly Data"
        lineChartView.notifyDataSetChanged()
    }
    
    func displayPortfolioData() {
        guard let chartsData = PortfolioDataManager.shared.getChartsData() else {
            return
        }
        
        for chart in chartsData.charts {
            switch chart.data {
            case .chartData(let chartData):
                setupPieChartData(data: chartData)
            case .lineChartData(let lineChartData):
                setupLineChartData(data: lineChartData)
            }
        }
    }
}

extension PortoViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let pieChartEntry = entry as? PieChartDataEntry else { return }
        let selectedLabel = pieChartEntry.label ?? ""
        navigateToTransactionDetail(transactionType: selectedLabel)
    }
    
    func navigateToTransactionDetail(transactionType: String) {
        let transactionDetailVC = TransactionDetailViewController()
        transactionDetailVC.transactionType = transactionType
        
        guard let chartsData = PortfolioDataManager.shared.getChartsData() else {
            return
        }
        
        for chart in chartsData.charts {
            switch chart.data {
            case .chartData(let chartData):
                for data in chartData {
                    if data.label == transactionType {
                        transactionDetailVC.transactions = data.data.map { ($0.trx_date, $0.nominal) }
                        break
                    }
                }
            default:
                break
            }
        }
        
        navigationController?.pushViewController(transactionDetailVC, animated: true)
    }
}
