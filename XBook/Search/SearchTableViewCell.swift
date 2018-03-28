//
//  SearchTableViewCell.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/3/27.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var BookName:UILabel?
    var Editor:UILabel?
    var userName:UILabel?
    var date:UILabel?
    var more:UITextView?
    var score:LDXScore?
    var type:UILabel?
    var cover:UIImageView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func initFrame(){
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.BookName = UILabel(frame: CGRect(x: 30, y: 10, width: 140, height: 25))
        
        self.contentView.addSubview(self.BookName!)
        
        self.Editor = UILabel(frame: CGRect(x: 30, y: 50, width: 140, height: 25))
        
        self.contentView.addSubview(self.Editor!)
        
        self.type = UILabel(frame: CGRect(x: 30, y: 90, width: 140, height: 25))
        
        self.contentView.addSubview(self.type!)
        
        self.cover = UIImageView(frame: CGRect(x: 190, y: 8, width: 180/1.273, height: 180))
        self.contentView.addSubview(self.cover!)
        
        self.more = UITextView(frame: CGRect(x: 8, y: 200, width: 350, height: 140))
        
        self.more?.isUserInteractionEnabled = false
        self.more?.layer.borderWidth = 1
        self.more?.layer.borderColor = UIColor.gray.cgColor
        self.contentView.addSubview(self.more!)
        
        self.userName = UILabel(frame: CGRect(x: 30, y: 350, width: 180, height: 25))
        
        self.userName?.textColor = UIColor.red
        self.contentView.addSubview(self.userName!)
        
        self.score = LDXScore(frame: CGRect(x: 30, y: 130, width: 140, height: 25))
        self.score?.isSelect = false
        self.score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.score?.max_star = 5
        self.score?.show_star = 5
        self.contentView.addSubview(self.score!)
        
        self.date = UILabel(frame: CGRect(x: 150, y: 350, width: 250, height: 25))
        
        self.contentView.addSubview(self.date!)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

