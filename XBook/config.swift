//
//  config.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import Foundation
import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let MAIN_RED = UIColor.init(red: 23/255, green: 23/255, blue: 233/255, alpha: 1.0)


func RGB(r: Float, g: Float, b: Float) ->UIColor {
    return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: 1.0)
}

