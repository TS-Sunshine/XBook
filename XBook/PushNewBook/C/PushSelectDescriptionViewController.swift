//
//  PushSelectDescriptionViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/5.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

typealias pushDescriptionBlock = (_ description:String) -> Void

class PushSelectDescriptionViewController: UIViewController {
    
    var descriptionTextView:JVFloatLabeledTextView?
    
    var callBack:pushDescriptionBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.descriptionTextView = JVFloatLabeledTextView(frame: CGRect(x: 8, y: 58, width: SCREEN_WIDTH - 16, height: SCREEN_HEIGHT - 58 - 8))
        self.view.addSubview(self.descriptionTextView!)
        self.descriptionTextView?.placeholder = "请输入书评！"
        self.descriptionTextView?.becomeFirstResponder()
        
//        XKeyBoard.registerHide(self)
//        XKeyBoard.registerShow(self)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector((keyboardWillHide)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sure() {
        self.callBack!((self.descriptionTextView?.text)!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notificaction:NSNotification){
        let dict = NSDictionary(dictionary: notificaction.userInfo!)

        let rect = (dict[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue

        self.descriptionTextView?.contentInset = UIEdgeInsetsMake(0, 0, (rect?.size.height)!, 0)
    }

    @objc func keyboardWillHide(notificaction:NSNotification){
        self.descriptionTextView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    
    
    
    
    
}
