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

    let plistUrl = Bundle.main.url(forResource: "Reasons", withExtension: "plist")
    let fileManager = FileManager.default
    var reasons: [Dictionary<String, Any>]?
    
    let poundRate = 0.69
    let yenRate = 113.94
    let euroRate = 0.89
    var dollarAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.delegate = self
        Reason.delegate = self
        
        if fileExistsInDocumentsDirectory() == false {
            seedDataToDocumentsDirectory()
        }
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func documentsDirectoryFileURL() -> URL? {
        do {
            let document = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let file = document.appendingPathComponent("Reasons.plist")
            return file
        } catch {
            print("Error getting file path.")
            return nil
        }
    }
    
    func fileExistsInDocumentsDirectory() -> Bool {
        if let file = documentsDirectoryFileURL() {
            let fileExists = FileManager().fileExists(atPath: file.path)
            return fileExists
        }
        
        return false
    }
    
    func seedDataToDocumentsDirectory() {
        do {
            let plistData = try Data(contentsOf: plistUrl!)
            
            if let file = documentsDirectoryFileURL() {
                try plistData.write(to: file)
            }
        } catch {
            print("Error writing file.")
        }
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
        
        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
        
        do {
            let plistData = try Data(contentsOf: documentsDirectoryFileURL()!)
            reasons = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as? [Dictionary<String, Any>]
            
            if var reasons = reasons {
                for reason in reasons {
                    print("Reason: \(String(describing: reason["Reason"])), Amount: \(String(describing: reason["Amount"]))")
                }
                
                let anotherReason = ["Reason" : Reason.text, "Amount" : inputTextField.text] as [String : Any]
                
                reasons.append(anotherReason)
                
                let serializedData = try PropertyListSerialization.data(fromPropertyList: reasons, format: PropertyListSerialization.PropertyListFormat.xml, options: 0)
                if let file = documentsDirectoryFileURL() {
                    try serializedData.write(to: file)
                    print(file)
                }
            }
        } catch {
            print("Error")
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

