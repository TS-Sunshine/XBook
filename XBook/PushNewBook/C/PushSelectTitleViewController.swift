//
//  PushSelectTitleViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/5.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

typealias pushTitleCallBack = (_ Title:String)->Void

class PushSelectTitleViewController: UIViewController {

    var textField: UITextField?
    var callBack: pushTitleCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.textField = UITextField(frame: CGRect(x: 15, y: 60, width: SCREEN_WIDTH - 30, height: 30))
        self.textField?.borderStyle = .roundedRect
        self.textField?.placeholder = "书评标题"
        self.view.addSubview(self.textField!)
        
        self.textField?.becomeFirstResponder()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    @objc func sure() {
        self.callBack!((self.textField?.text)!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
