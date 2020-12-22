//
//  CurrencyTableCell.swift
//  currency
//
//  Created by Noman on 20/12/2020.
//

import UIKit

class CurrencyTableCell: UITableViewCell {

    @IBOutlet weak var lblCurrencyCode: UILabel!
    @IBOutlet weak var lblConversionInfo: UILabel!
    @IBOutlet weak var lblDigit: UILabel!
    @IBOutlet weak var lblCurrencyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCellData(currency:Currency, selecetedCurrency: Currency, userValue:Double){
        
        lblCurrencyName.text = currency.name!
        lblCurrencyCode.text = currency.iso_code!
        let amount = selecetedCurrency.rate / currency.rate
        
        lblConversionInfo.text = "1 \(currency.iso_code!) = \(amount.dollarString) \(selecetedCurrency.iso_code ?? DEFAULT_CURRENCY_CODE)"
        
        lblDigit.text = AppUtil.getConvertedValue(selectedCR: selecetedCurrency.rate, rate: amount, userValue: userValue).dollarString
       
        
    }
    
}
