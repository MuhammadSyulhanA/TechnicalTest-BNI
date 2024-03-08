//
//  ViewController.swift
//  Case4-MobileAppPushNotif
//
//  Created by M. Syulhan Al Ghofany on 08/03/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var titleText: String?
    var transactionCode: String?
    
    private let titleLabel = UILabel()
    private let transactionCodeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        titleLabel.text = titleText
        titleLabel.textColor = .black
        transactionCodeLabel.text = transactionCode
        transactionCodeLabel.textColor = .black
        
        view.addSubview(titleLabel)
        view.addSubview(transactionCodeLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        transactionCodeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}

