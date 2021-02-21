//
//  CKDataModel.swift
//  Crypto Keyboard
//
//  Created by zj on 2021/2/9.
//  Copyright © 2021 Onekey. All rights reserved.
//

import Foundation
import SwiftUI

struct CKModel {
    var pasteboardItems: [String]
    
    init() {
        pasteboardItems = CKModel.readFromKeychain()
    }
    
    mutating func add(item: String) {
        pasteboardItems.insert(item, at: 0)
        if pasteboardItems.count > 10 {
            _ = pasteboardItems.popLast()
        }
        save()
    }
    
    mutating func remove(at index: Int) {
        pasteboardItems.remove(at: index)
        save()
    }
    
    func save() {
        CKModel.writeTokeychain(pasteboardItems)
    }
    
    static func readFromKeychain() -> [String] {
        if let retrievedData = KeychainWrapper.standard.data(forKey: "CKPasteboardItems") {
            do {
                if let decodedArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(retrievedData) as? [String] {
                    return decodedArray
                }
            } catch {
                print("Couldn't read file.")
            }
        }
        return []
    }
    
    static func writeTokeychain(_ items: [String]) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: true)
            _ = KeychainWrapper.standard.set(encodedData, forKey: "CKPasteboardItems")
        } catch {
            print("Couldn't encoded data.")
        }
    }
}

