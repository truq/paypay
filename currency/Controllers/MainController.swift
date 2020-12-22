//
//  MainController.swift
//  currency
//
//  Created by Noman on 18/12/2020.
//

import UIKit
import DropDown
import SwiftyJSON

class MainController: BaseController {
    
    let dropDown = DropDown()
    var currencies:[Currency] = []
    var selectedCurrecny : Currency?
    let identifier = "CurrencyTableCell"
    var userInputValue:Double = DEFAULT_CURRENCY_VALUE
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnSelectCurrency: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCellForTableView()
        
        fetchCurrencyListFromNetwork {
            self.currencies = CurrencyModel.getCurrenciesfromDB()
            self.fetchCurrencyLiveFromNetwork {
                self.setSelectedCurrency()
            }
        }
    
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func didTapOnCurrencySelection(_ sender: UIButton) {
        showDropDown(sender: sender)
    }
    
}

// Tableview Delegates and DataSource
extension MainController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:identifier, for: indexPath) as! CurrencyTableCell
        cell.setCellData(currency: currencies[indexPath.row], selecetedCurrency: selectedCurrecny!, userValue: userInputValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

//Extend Controller
extension MainController {
    
    func registerCellForTableView(){
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func setSelectedCurrency() {
        selectedCurrecny = currencies.filter({$0.iso_code == DEFAULT_CURRENCY_CODE}).first
        btnSelectCurrency.setTitle(selectedCurrecny?.name ?? DEFAULT_BTN_TEXT, for: .normal)
        self.tableView.reloadData()
    }
    
    func getDataForDropDown() -> [String]{
        
        let titles = currencies.map({ (currency: Currency) -> String in
            currency.name ?? ""
        })
        return titles

    }
    
    func fetchCurrencyLiveFromNetwork(callback: @escaping  (() -> Void)){
        
        if (AppUtil.isLimitExpired()){
            MainServices.fetchLiveRate(params: [ACCESS_KEY:ACCESS_KEY_VALUE]) { (response, error) in
                AppUtil.setRequestLimitTime()
                AppUtil.setFirstRequest()
                if let dict = response?["quotes"].dictionary {
                    self.updateCurrencyValues(dict: dict)
                }
                callback()
            }
        }else{
            callback()
        }
        
    }
    
    func updateCurrencyValues(dict: Dictionary<String,JSON>){
        
        for (key, value) in dict {
            let code = String(key.dropFirst(3))
            try! DBManager.shared.realm.write {
                self.currencies.filter({$0.iso_code == code}).first?.rate = value.double ?? DEFAULT_CURRENCY_VALUE
            }
        }
        
    }
    
    func showDropDown(sender: UIButton){
        
        dropDown.dataSource = getDataForDropDown().sorted()
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
          guard let _ = self else { return }
          sender.setTitle(item, for: .normal)
            self?.selectedCurrecny = self?.currencies[index]
            self?.tableView.reloadData()
        }
    }
    
}


// Input Field Operations
extension MainController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        userInputValue = Double(textField.text ?? "") ?? DEFAULT_CURRENCY_VALUE
        self.tableView.reloadData()
        return true
    }
}
