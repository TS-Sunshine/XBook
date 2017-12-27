//
//  PushNewBookViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/12.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushNewBookViewController: UIViewController, BookTitleDelegate {
    
    /// 发布书评头视图
    var bookTitle:BookTitleView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.bookTitle = BookTitleView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.view.addSubview(self.bookTitle!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 关闭页面
    @objc func close(){
        dismiss(animated: true) {
            
        }
    }
    func sure() {
        
    }

}
