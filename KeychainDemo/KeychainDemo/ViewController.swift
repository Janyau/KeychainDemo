//
//  ViewController.swift
//  KeychainDemo
//
//  Created by yaojian on 2022/10/15.
//

import UIKit
import Security

class ViewController: UIViewController {
    var accout = "14"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func addItem(_ sender: Any) {
        let password = "passowrd--\(accout)"
        let keychainItemQuery = [kSecValueData: password.data(using: .utf8)!,
                                     kSecClass: kSecClassGenericPassword,
                               kSecAttrAccount: "user--\(accout)"] as CFDictionary
        
        let status = SecItemAdd(keychainItemQuery, nil)
        print("status = \(status)")
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: "user--\(accout)"] as CFDictionary
        SecItemDelete(query)
    }
    
    @IBAction func updateItem(_ sender: Any) {
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: "user--\(accout)"] as CFDictionary
        let update = [kSecValueData: "updatepassword--\(accout)".data(using: .utf8)] as CFDictionary
        SecItemUpdate(query, update)
    }
    
    @IBAction func queryItem(_ sender: Any) {
       let query = [kSecClass: kSecClassGenericPassword,
              kSecAttrAccount: "user--\(accout)",

               kSecReturnData: true] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        if let data = result as? Data, let str = String(data: data, encoding: .utf8) {
            print(str)
        }
    }
}

