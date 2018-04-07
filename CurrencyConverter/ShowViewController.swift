//
//  ShowViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Sobhi  Fouda on 4/6/18.
//  Copyright © 2018 Mohamed Sobhi  Fouda. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {


    let plistUrl = Bundle.main.url(forResource: "Reasons", withExtension: "plist")
    let fileManager = FileManager.default
    var reasons: [Dictionary<String, Any>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
        ShowText.text = ""
        do {
            let plistData = try Data(contentsOf: documentsDirectoryFileURL()!)
            reasons = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as? [Dictionary<String, Any>]
            
            if let reasons = reasons {
                for reason in reasons {
                    print("Reason: \(String(describing: reason["Reason"])), Amount: \(String(describing: reason["Amount"]))")
                    
                    ShowText.text = ShowText.text + "Reason: \(String(describing: reason["Reason"])) \nAmount: \(String(describing: reason["Amount"]))$"
                    ShowText.text = ShowText.text + "\n" + "\n"
                }
                
            }
        } catch {
            print("Error")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var ShowText: UITextView!
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
