//
//  PushNewBookViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/12.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushNewBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "新建书评"
        self.view.backgroundColor = MAIN_RED
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func close(){
        dismiss(animated: true) {
            
        }
    }
    func sure() {
        
    }

}
