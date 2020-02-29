//
//  FirstViewController.swift
//  Fees Calculator
//
//  Created by George on 29/02/2020.
//  Copyright © 2020 George. All rights reserved.
//

import UIKit

class eBayViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var shippingTextField: UITextField!
    @IBOutlet weak var ebayFeesLabel: UILabel!
    @IBOutlet weak var paypalFeesLabel: UILabel!
    @IBOutlet weak var totalProfitLabel: UILabel!

    // Store calculated fees here
    var ebayFee: Double = 0;
    var paypalFee: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .dark
        
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
                    
                    ebayFee = price / 100 * 10 // 10%
                    paypalFee = price / 100 * 3.4 // 3.4%
                    
                    let currencyFormatter = NumberFormatter()
                    currencyFormatter.usesGroupingSeparator = true
                    currencyFormatter.numberStyle = .currency
                    
                    ebayFeesLabel.text? = "eBay Fees: " + currencyFormatter.string(for: ebayFee)!
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
                    let totalProfit = price - shipping - ebayFee - paypalFee
                    totalProfitLabel.text? = "Total Profit: " + currencyFormatter.string(for: totalProfit)!
                    
            }
         }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
