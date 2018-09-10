//
//  ViewController.swift
//  tipHelper
//
//  Created by Ming Lei on 9/7/18.
//  Copyright © 2018 Ming Lei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var amountTextField: UITextField!
  @IBOutlet var taxTextField: UITextField!
  @IBOutlet var tipTextField: UITextField!
  @IBOutlet var tipRateSegmentedControl: UISegmentedControl!
  @IBOutlet var totalTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  let taxRate = 0.0875
  var tipRate = 0.15
  
  @IBAction func infoButtonTouched(_ sender: UIButton) {
    guard let url = URL(string: "https://github.com/popoway/tipHelper") else { return }
    UIApplication.shared.open(url)
  }

  func calcValues(){
    if (amountTextField.text == "") {
      amountTextField.text = "0.00"
    }
    let amount = Double(amountTextField.text!)
    let tax = round(100 * (amount! * taxRate))/100
    let tip = round(100 * (amount! * tipRate))/100
    let total = amount! + tax + tip
    taxTextField.text = String(tax)
    tipTextField.text = String(tip)
    totalTextField.text = String(total)
    return
  }
  
  @IBAction func amountTextFieldValueChanged(_ sender: UITextField) {
    calcValues()
  }
  
  @IBAction func tipTextFieldValueChanged(_ sender: UITextField) {
    tipRateSegmentedControl.selectedSegmentIndex = 4
    var amount = Double(amountTextField.text!)
    let tax = Double(taxTextField.text!)
    var tip = Double(tipTextField.text!)
    if (amountTextField.text == "") {
      amountTextField.text = "0.00"
      amount = 0.00
    }
    if (tipTextField.text == "") {
      tipRate = 0.15
      tipRateSegmentedControl.selectedSegmentIndex = 1
      tip = round(100 * (amount! * tipRate))/100
    }
    totalTextField.text = String(amount! + tax! + tip!)
  }
  
  @IBAction func tipRateChanged(_ sender: UISegmentedControl) {
    switch tipRateSegmentedControl.selectedSegmentIndex
    {
    case 0:
      tipRate = 0.10
      calcValues()
    case 1:
      tipRate = 0.15
      calcValues()
    case 2:
      tipRate = 0.20
      calcValues()
   case 3:
      tipRate = 0.25
      calcValues()
    default:
      break
    }
  }
  
  @IBAction func totalTextFieldValueChanged(_ sender: UITextField) {
    tipRateSegmentedControl.selectedSegmentIndex = 4
    var amount = Double(amountTextField.text!)
    let tax = Double(taxTextField.text!)
    let tip = Double(tipTextField.text!)
    if (amountTextField.text == "") {
      amountTextField.text = "0.00"
      amount = 0.00
    }
    if (totalTextField.text == "") {
      totalTextField.text = String(amount! + tax! + tip!)
    }
    let total: Double = Double(totalTextField.text!)!
    if (total < Double(amount! + tax!)) {
      totalTextField.text = String(amount! + tax!)
    }
    tipTextField.text = String(total - amount! - tax!)
  }
  
  
  @IBAction func startOverTouched(_ sender: UIButton) {
    amountTextField.text = ""
    taxTextField.text = "0.00"
    tipTextField.text = "0.00"
    tipRateSegmentedControl.selectedSegmentIndex = 1 // back to 15%
    totalTextField.text = "0.00"
  }
  
  @IBAction func shareTouched(_ sender: UIButton) {
    let textToShare = totalTextField.text
    
    let objectsToShare = [textToShare!] as [Any]
    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
    
    activityVC.popoverPresentationController?.sourceView = sender
    self.present(activityVC, animated: true, completion: nil)
  }
}

