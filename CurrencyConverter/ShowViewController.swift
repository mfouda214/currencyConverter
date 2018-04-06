//
//  ShowViewController.swift
//  CurrencyConverter
//
//  Created by Mohamed Sobhi  Fouda on 4/6/18.
//  Copyright © 2018 Mohamed Sobhi  Fouda. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {


    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        ShowText.text = FileSaved()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var ShowText: UITextView!
    
    func FileSaved() -> String{
        do {
            let documents = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            
            print(documents)
            let url = URL(string: "Reason.txt", relativeTo: documents)
    
            if let url = url {
                
                let textFromFile = try String(contentsOf: url)
                let text = textFromFile
                
                return text
            }
        } catch {
            print("Error getting path")
        }
        return "nil"
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
