//
//  TransactionDetailViewController.swift
//  Case3-MobileAppPortfolio
//
//  Created by M. Syulhan Al Ghofany on 08/03/24.
//

import UIKit
import SnapKit

class TransactionDetailViewController: UIViewController {
    
    var transactionType: String?
    var transactions: [(trx_date: String, nominal: Int)] = []
    
    private let tableView = UITableView()
    private let typeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        typeLabel.text = transactionType ?? "Transaction Detail"
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension TransactionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "Date: \(transaction.trx_date), Nominal: \(transaction.nominal)"
        return cell
    }
}
