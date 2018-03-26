//
//  PushBookCell.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/3/26.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushBookCell: UITableViewCell {
    
    var bookName: UILabel?
    
    var editor: UILabel?
    
    var more: UILabel?
    
    var coverImageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        self.bookName = UILabel(frame: CGRect(x: 78, y: 8, width: 242, height: 25))
        
        self.editor = UILabel(frame: CGRect(x: 78, y: 33, width: 242, height: 25))
        
        self.more = UILabel(frame: CGRect(x: 78, y: 66, width: 242, height: 25))
        
        
        self.more?.textColor = UIColor.gray
        
        self.contentView.addSubview(self.bookName!)
        self.contentView.addSubview(self.editor!)
        self.contentView.addSubview(self.more!)
        
        self.coverImageView = UIImageView(frame: CGRect(x: 8, y: 9, width: 56, height: 70))
        self.contentView.addSubview(self.coverImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
