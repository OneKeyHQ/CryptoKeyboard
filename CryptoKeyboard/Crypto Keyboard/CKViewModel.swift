//
//  CKViewModel.swift
//  Crypto Keyboard
//
//  Created by zj on 2021/2/10.
//  Copyright © 2021 Onekey. All rights reserved.
//

import Foundation
import SwiftUI

enum CKPasteboardItemType: String {
    case normal = "普通"
    case privateKey = "私钥"
    case address = "地址"
}

class CKViewModel: ObservableObject {
    @Published private var model: CKModel = CKModel()
    @Published var showInputModeSwitchKey: Bool = false
    
    var textDocumentProxy: UITextDocumentProxy
    var switchInputModeCallback: () -> Void
    let regexHelper = CKRegexHelper()
    
    var items: [CKPasteboardItem] {
        model.pasteboardItems.map { (item) -> CKPasteboardItem in
            let type = regexHelper.typeOfContent(content: item)
            return CKPasteboardItem(content: item, id: item.hash, type: type)
        }
    }
    
    init(withTextDocumentProxy proxy: UITextDocumentProxy, switchInputMode callback: @escaping () -> Void) {
        textDocumentProxy = proxy
        switchInputModeCallback = callback
    }
    
    func switchInputMode() {
        switchInputModeCallback()
    }
    
    func paste(content: String) {
        textDocumentProxy.insertText(content)
    }
    
    func delete() {
        textDocumentProxy.deleteBackward()
    }
    
    func add(_ item: String) {
        model.add(item: item)
    }
    
    func remove(At index: Int) {
        model.remove(at: index)
    }
}

struct CKPasteboardItem: Identifiable {
    let content: String
    var id: Int
    var type: CKPasteboardItemType
}

class CKRegexHelper {
    
    let ethAddrRE = try! NSRegularExpression(pattern: "0x[a-fA-F0-9]{40}", options: .caseInsensitive)
    let btcAddrRE = try! NSRegularExpression(pattern: "(1|3)[a-zA-Z1-9]{26,33}", options: .caseInsensitive)
    let prikeyRE = try! NSRegularExpression(pattern: "(0x)?[a-fA-F0-9]{64}", options: .caseInsensitive)
    
    func typeOfContent(content: String) -> CKPasteboardItemType {
        if prikeyRE.matche(content) {
            return .privateKey
        } else if ethAddrRE.matche(content) || btcAddrRE.matche(content) {
            return .address
        }
        return .normal
    }
}

extension NSRegularExpression {
    func matche(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
