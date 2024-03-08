//
//  PromoViewController.swift
//  Case2-MobileAppPromo
//
//  Created by M. Syulhan Al Ghofany on 06/03/24.
//

import UIKit
import SnapKit
import SDWebImage

// step 4 and 7
class PromoViewController: UIViewController {
    
    var presentor: ViewToPresenterProtocol?
    var tableView: UITableView = UITableView()
    var promoArrayList: [PromoModel] = []
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Promo Module"
        presentor?.startFetchingPromo()
        showProgressIndicator()
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoticeCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func showProgressIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.style = .large
            self.activityIndicator.center = self.view.center
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    private func hideProgressIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}

extension PromoViewController: PresenterToViewProtocol {
    func showPromo(promoArray: [PromoModel]) {
        promoArrayList = promoArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.hideProgressIndicator()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.hideProgressIndicator()
            let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension PromoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeCell
        let promo = promoArrayList[indexPath.row]
        cell.configure(with: promo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presentor?.showDetailController(navigationController: navigationController!)
        guard let navigationController = navigationController else { return }
        let selectedPromo = promoArrayList[indexPath.row]
        if let detailURL = URL(string: selectedPromo.detail!) {
            presentor?.showDetailController(navigationController: navigationController, detailURL: detailURL)
        }
        
    }
}

class NoticeCell: UITableViewCell {
    private let idPromo = UILabel()
    private let namePromo = UILabel()
    private let imagePromo = UIImageView()
    private let labelStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imagePromo)
        addSubview(labelStackView)
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        
        labelStackView.addArrangedSubview(idPromo)
        labelStackView.addArrangedSubview(namePromo)
        
        imagePromo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.width.height.equalTo(50)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(imagePromo.snp.top)
            make.left.equalTo(imagePromo.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    func configure(with promo: PromoModel) {
        if let imageUrlString = promo.imagesURL {
            if imageUrlString.contains("bit.ly") {
                imagePromo.image = UIImage(named: "bni_flek")
//                let driveUrl = "https://drive.google.com/file/d/1qtChxKOGH1pHAixtJcLM7B6PeQxoge0r/view?usp=sharing"
//                if let imageUrl = URL(string: driveUrl) {
//                    imagePromo.sd_setImage(with: imageUrl, completed: nil)
//                }
            } else {
                if let imageUrl = URL(string: imageUrlString) {
                    imagePromo.sd_setImage(with: imageUrl, completed: nil)
                }
            }
        }
        
        idPromo.text = String(describing: promo.id)
        namePromo.text = promo.name
    }
}
