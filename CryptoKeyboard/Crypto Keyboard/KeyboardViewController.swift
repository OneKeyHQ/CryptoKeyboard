//
//  KeyboardViewController.swift
//  Crypto Keyboard
//
//  Created by zj on 2021/2/4.
//  Copyright © 2021 Onekey. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    var viewModel: CKViewModel?
    var timer: Timer?

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = CKViewModel.init(withTextDocumentProxy: self.textDocumentProxy) { [weak self] in
            self?.advanceToNextInputMode()
        }
        
        view.backgroundColor = UIColor.clear
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self]
            _ in self?.checkPasteboard()
        }

        let hostingController = UIHostingController(rootView: KeyboardView().environmentObject(self.viewModel!))
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.view.backgroundColor = UIColor.clear
        view.addSubview(hostingController.view)
        addChild(hostingController)
        
        self.nextKeyboardButton = UIButton(type: .system)
    }
    
    @objc func checkPasteboard() {
        if !UIPasteboard.general.hasStrings {
            return
        }

        if let item = UIPasteboard.general.string {
            if item.count == 0 {
                return
            }
            self.viewModel?.add(item)
            UIPasteboard.general.strings = []
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        if self.needsInputModeSwitchKey {
            self.viewModel?.showInputModeSwitchKey = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillDisappear")
        self.timer?.invalidate()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
