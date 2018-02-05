
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
    @objc func choiceCover()
}
class BookTitleView: UIView  {
    
    /// 封面
    var bookCover:UIButton?
    
    /// 书名
    var bookName:JVFloatLabeledTextField?
    
    /// 作者名
    var bookEditor:JVFloatLabeledTextField?
    
    
    weak var delegate:BookTitleDelegate?
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.bookCover = UIButton(frame: CGRect(x: 10, y: 8, width: 110, height: 141))
        self.bookCover?.setImage(UIImage(named:"Cover"), for: .normal)
        self.addSubview(self.bookCover!)
        self.bookCover?.addTarget(self, action:#selector(choiceCover), for: .touchUpInside)
        
        self.bookName = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+40, width: SCREEN_WIDTH-128-15, height: 30))
        self.bookEditor = JVFloatLabeledTextField(frame: CGRect(x: 128, y: 8+70+40, width: SCREEN_WIDTH-128-15, height: 30))
        
        self.bookName?.placeholder = "书名"
        self.bookEditor?.placeholder = "作者"
        
        
        self.addSubview(self.bookName!)
        self.addSubview(self.bookEditor!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 选择封面
    @objc func choiceCover() {
       self.delegate?.choiceCover()
    }
    

}
