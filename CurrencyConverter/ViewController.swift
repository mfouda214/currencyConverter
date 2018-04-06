//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Sobhi Fouda on 2/3/18.
//  Copyright © 2018 Mohamed Sobhi  Fouda. All rights reserved.
//  All on Git repo now
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {

    let fileManager = FileManager.default
    
    let poundRate = 0.69
    let yenRate = 113.94
    let euroRate = 0.89
    var dollarAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.delegate = self
        Reason.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Called when 'return' key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //playing around :-)
        if let amount = Double(inputTextField.text!) {
            dollarAmount = amount
        }
        poundLabel.text = "\(dollarAmount * poundRate)"
        yenLabel.text = "\(dollarAmount * yenRate)"
        euroLabel.text = "\(dollarAmount * euroRate)"
        dollarAmount = 0.0
        //end try
        return true
    }
    
    // Called when user taps outside the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //playing around :-)
        if let amount = Double(inputTextField.text!) {
            dollarAmount = amount
        }
        poundLabel.text = "\(dollarAmount * poundRate)"
        yenLabel.text = "\(dollarAmount * yenRate)"
        euroLabel.text = "\(dollarAmount * euroRate)"
        dollarAmount = 0.0
        //end try
        view.endEditing(true)
    }
    
    @IBAction func convertCurrency(_ sender: UIButton) {
        
        if let amount = Double(inputTextField.text!) {
            dollarAmount = amount
        }
        poundLabel.text = "\(dollarAmount * poundRate)"
        yenLabel.text = "\(dollarAmount * yenRate)"
        euroLabel.text = "\(dollarAmount * euroRate)"
        dollarAmount = 0.0
        
    }
    
    @IBAction func clear(_ sender: UIButton) {
        
        inputTextField.text = ""
        poundLabel.text = "\(dollarAmount * 0.00)"
        yenLabel.text = "\(dollarAmount * 0.00)"
        euroLabel.text = "\(dollarAmount * 0.00)"
        dollarAmount = 0.00
        
    }
    
    @IBAction func Save(_ sender: Any) {
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            
            print(documents)
            let url = URL(string: "Reason.txt", relativeTo: documents)
            let stringToWrite = Reason.text
            if let url = url {
                try stringToWrite?.write(to: url, atomically: true, encoding: String.Encoding.utf8)
                let textFromFile = try String(contentsOf: url)
                print(textFromFile)
            }
        } catch {
            print("Error getting path")
        }
    }
    
    @IBOutlet weak var poundLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var Reason: UITextField!
    
    @IBAction func History(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InformationViewController")
        
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender as? UIBarButtonItem
        popover.delegate = self
        present(viewController, animated: true, completion:nil)
        
    }
    
    @IBAction func BarHistory(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "InformationViewController")
        viewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
        popover.barButtonItem = sender as? UIBarButtonItem
        popover.delegate = self
        present(viewController, animated: true, completion:nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ViewController.dismissViewController))
        navigationController.topViewController?.navigationItem.rightBarButtonItem = doneButton
        return navigationController
        
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    
}

