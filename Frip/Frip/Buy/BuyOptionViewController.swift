//
//  BuyOptionViewController.swift
//  Frip
//
//  Created by 김태훈 on 2021/01/10.
//

import UIKit

class BuyOptionViewController: BaseViewController {
    
    private let jwt = UserDefaults.standard.string(forKey: "userJWT")!
    var buyOption:Int = 0
    var fripIdx: Int = 0
    var options:[FripOption] = []
    var clickOptions: SelectOption = SelectOption(option: FripOption(fripOptionIdx: 0, fripOption: "", price: "", limitcount: "", isEnd: ""), count: 0)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var finishButton: UIButton!
    
    init(_ fripIdx: Int) {
        self.fripIdx = fripIdx
        
        super.init(nibName: "BuyOptionViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.selectionFollowsFocus = false
        tableView.delegate = self
        tableView.dataSource = self
        
        finishButton.cornerRadius = finishButton.bounds.height / 8
        
        tableView.register(UINib(nibName: "OptionHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionHeaderTableViewCell")
        tableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        tableView.register(UINib(nibName: "OptionClickTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionClickTableViewCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.title = "옵션 선택"
        self.tabBarController?.tabBar.isHidden = true
        BuyGetDataManager().getFripOptions(targetURL: URL(string: Constant.ALL_FRIP)!, fripIdx: fripIdx, header: jwt, vc: self)
    }
    
    @IBAction func finishTouchDown(_ sender: Any) {
        // 결제 api 서버 연동 해야함
        if buyOption != 0{
            BuyPostDataManager().postBuyFrip(targetURL: Constant.ALL_FRIP, fripIdx: fripIdx,option: buyOption, vc: self)
        } else {
            self.presentAlert(title: "옵션을 선택 하지 않았습니다")
        }
    }
    
    func postSuccess() {
        self.navigationController?.popToRootViewController(animated:true)
    }
    
    func getOptions(_ result: [FripOption]) {
        for r in result { options.append(r) }
        tableView.reloadData()
    }
    
    @objc func cancelTouchDown(_ sender: UIButton!) {
        buyOption = 0
        clickOptions = SelectOption(option: FripOption(fripOptionIdx: 0, fripOption: "", price: "", limitcount: "", isEnd: ""), count: 0)
        tableView.reloadData()
    }
}

extension BuyOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return options.count
        } else {
            return clickOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionHeaderTableViewCell") as! OptionHeaderTableViewCell
            return cell
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell") as! OptionTableViewCell
            if options.count != 0 {
                cell.option = options[indexPath.row]
                cell.optionTitleLabel.text = options[indexPath.row].fripOption
                if options[indexPath.row].limitcount == "null" {
                    cell.count = 0
                    cell.countLabel.text = "남은 수량 0개"
                    cell.priceLabel.text = options[indexPath.row].price
                } else {
                    cell.count = 1
                    cell.priceLabel.text = options[indexPath.row].price
                    cell.countLabel.text = options[indexPath.row].limitcount
                }
            }
            cell.backgroundColor = .systemGray6
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionClickTableViewCell") as! OptionClickTableViewCell
            if clickOptions.count != 0 {
                cell.priceLabel.text = clickOptions.option.price
                cell.cancelButton.tag = indexPath.row
                cell.optionLabel.text = clickOptions.option.fripOption
                cell.cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! OptionTableViewCell
            if cell.count != 0 {
                buyOption = cell.option.fripOptionIdx
                clickOptions = SelectOption(option: cell.option, count: 1)
                tableView.reloadData()
            }
            buyOption = cell.option.fripOptionIdx
            clickOptions = SelectOption(option: cell.option, count: 1)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        } else if indexPath.section == 1 {
            return 85
        } else {
            if clickOptions.count == 1{
                return 120
            } else {
                return 0
            }
        }
    }
    
    
}
