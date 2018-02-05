//
//  PushViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.title = "新建书评"
        
        self.setNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// 新建书评
    func setNavigationBar(){
        //创建navigationbar
        let navigationView = UIView(frame:CGRect(x:0,y:-20,width:SCREEN_WIDTH,height:64))
        navigationView.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        //
        let addNavigationBarBtn = UIButton.init(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addNavigationBarBtn.setImage(UIImage(named:"plus circle"), for:.normal)
        addNavigationBarBtn.setTitle("   新建书评", for: .normal)
        addNavigationBarBtn.setTitleColor(UIColor.black, for: .normal)
        addNavigationBarBtn.contentHorizontalAlignment = .left
        addNavigationBarBtn.addTarget(self, action: #selector(pushNewBook), for: .touchUpInside)
        navigationView.addSubview(addNavigationBarBtn)
    }
    
    @objc func pushNewBook(){
        let vc = PushNewBookViewController()
        GeneralFactory.addTitleWithTitle(target: vc)
        self.present(vc, animated: true) {
        }
    }
   
}

