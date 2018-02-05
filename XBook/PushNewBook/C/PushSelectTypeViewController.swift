//
//  PushSelectTypeViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/5.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushSelectTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sure() {
        print("ceee")
    }

}
