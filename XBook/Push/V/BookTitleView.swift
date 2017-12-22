
//
//  BookTitleView.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/22.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

@objc protocol BookTitleDelegate {
    @objc optional func choiceCover()
}
class BookTitleView: UIView  {

    var bookCover:UIButton?
    var bookName:JVFloatLabeledTextField?
    var bookEditor:JVFloatLabeledTextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bookCover = UIButton(frame: CGRect(x: 10, y: 8, width: 110, height: 140))
        self.bookCover?.setImage(UIImage.init(named: "Cover"), for: .normal)
        self .addSubview(self.bookCover!)
        self.bookCover?.addTarget(self, action: #selector(BookTitleDelegate.choiceCover), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func choiceCover() {
        
    }
    

}
