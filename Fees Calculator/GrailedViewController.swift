//
//  GrailedViewController.swift
//  Fees Calculator
//
//  Created by George on 29/02/2020.
//  Copyright © 2020 George. All rights reserved.
//

import UIKit

class GrailedViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var shippingTextField: UITextField!
    @IBOutlet weak var grailedFeesLabel: UILabel!
    @IBOutlet weak var paypalFeesLabel: UILabel!
    @IBOutlet weak var totalProfitLabel: UILabel!
    @IBOutlet weak var feeSelection: UISegmentedControl!
    
    // Store calculated fees here
    var grailedFee: Double = 0;
    var paypalFee: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        
        priceTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        shippingTextField.attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    // Actions
    @IBAction func priceEntered(_ sender: UITextField) {
        guard let text = priceTextField.text else {
                           return
                       }
        
            if let price = Double(text) { // If we can convert value of price to Double
                            
                grailedFee = price / 100 * 6 // 6%
                            
                // Domestic Fee
                if feeSelection.selectedSegmentIndex == 0 {
                    paypalFee = price / 100 * 2.9 + 0.30 // 2.9% + 30 cents

                }
                // International Fee
                else if feeSelection.selectedSegmentIndex == 1 {
                    paypalFee = price / 100 * 4.4 + 0.30 // 4.4% + 30 cents
                }
                                            
                let currencyFormatter = NumberFormatter()
                currencyFormatter.usesGroupingSeparator = true
                currencyFormatter.numberStyle = .currency
                            
                grailedFeesLabel.text? = "Grailed Fees: " + currencyFormatter.string(for: grailedFee)!
                paypalFeesLabel.text? = "PayPal Fees: " + currencyFormatter.string(for: paypalFee)!
            }
        }
    
    @IBAction func shippingEntered(_ sender: UITextField) {
        // If both text fields have text, run the code below
                    guard let text = priceTextField.text, let text2 = shippingTextField.text else {
                        return
                    }
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
                    
            if let price = Double(text) {
                if let shipping = Double(text2) { // If we can convert value of textField to Double
                    let totalProfit = price - shipping - grailedFee - paypalFee
                    totalProfitLabel.text? = "Total Profit: " + currencyFormatter.string(for: totalProfit)!
                }
             }
        }
}
