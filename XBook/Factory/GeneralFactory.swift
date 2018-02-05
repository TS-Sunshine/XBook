//
//  GeneralFactory.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/12.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit


class GeneralFactory: NSObject {
    static func addTitleWithTitle(target:UIViewController, leftTitle: String = "关闭", rightTitle: String = "确认"){
        let leftBtn = UIButton(frame: CGRect(x: 10, y: 20, width: 40, height: 20))
        leftBtn.titleLabel?.text = "关闭"
        leftBtn .setTitleColor(UIColor.black, for: .normal)
        leftBtn.setTitle(leftTitle, for: .normal)
        target.view.addSubview(leftBtn)
        
        
        let rightBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - 50, y: 20, width: 40, height: 20))
        rightBtn.titleLabel?.text = "确认"
        rightBtn .setTitleColor(UIColor.black, for: .normal)
        rightBtn.setTitle(rightTitle, for: .normal)
        target.view.addSubview(rightBtn)
        
        
        leftBtn.addTarget(target, action: Selector("close"), for: .touchUpInside)
        rightBtn.addTarget(target, action: Selector("sure"), for: .touchUpInside)
        
    }

}
