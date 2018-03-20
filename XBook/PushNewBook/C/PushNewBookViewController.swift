//
//  PushNewBookViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/12.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit

class PushNewBookViewController: UIViewController {
    
    
    /// 发布书评头视图
    var bookTitleView:BookTitleView?
    
    var tableView:UITableView?
    
    var titleArray:Array<String> = []
    
    var bookTitle:String = ""
    
    var score:LDXScore?
    
    var type = ""
    
    var detailType = ""
    
    var bookDescription = ""
    //是否实现星星
    var showScore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        self.bookTitleView = BookTitleView(frame: CGRect(x: 0, y: 40, width: SCREEN_WIDTH, height: 160))
        self.bookTitleView?.delegate = self
        self.view.addSubview(self.bookTitleView!)
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 200), style: .grouped)
        self.tableView?.tableFooterView = UIView()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题", "评分", "分类", "书评"]
        
        self.score = LDXScore(frame: CGRect(x: 100, y: 10, width: 100, height: 22))
        self.score?.isSelect = true
        self.score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.score?.show_star = 5
        self.score?.max_star = 5
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
    
    /// 发布书籍
    @objc func sure() {
        let dict = [
            "BookName" : (self.bookTitleView?.bookName?.text)!,
            "BoolEditor" : (self.bookTitleView?.bookEditor?.text)!,
            "BookCover" : (self.bookTitleView?.bookCover?.currentImage)!,
            "title" : self.bookTitle,
            "score" : String(describing: self.score?.show_star),
            "type" : self.type,
            "detailType" : self.detailType,
            "description" : self.bookDescription
            ] as [String : Any] as [String : Any]
    }
 
    
    
}

// MARK: - 实现BookTitleDelegate代理方法
extension PushNewBookViewController:BookTitleDelegate {
    func choiceCover() {
        let vc = PhotoPickerViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}


// MARK: - 实现PhotoPickerDelegate代理方法
extension PushNewBookViewController:PhotoPickerDelegate {
    func getImageFromPicker(image: UIImage) {
        let imageSize:CGRect = CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 1.273)
        let CroVC = VPImageCropperViewController(image: image, cropFrame:imageSize , limitScaleRatio: 3)
        CroVC?.delegate = self
        self.present(CroVC!, animated: true, completion: nil)
    }
    
    
}


// MARK: - 实现VPImageCropperDelegate的代理方法
extension PushNewBookViewController:VPImageCropperDelegate {
    
    
    /// 完成的方法
    /// - Parameters:
    ///   - cropperViewController:
    ///   - editedImage:
    func imageCropper(_ cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.bookTitleView?.bookCover?.setImage(editedImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
    /// 取消的方法
    ///
    /// - Parameter cropperViewController:
    func imageCropperDidCancel(_ cropperViewController: VPImageCropperViewController!) {

        self.dismiss(animated: true, completion: nil)
    }
    
    
}


// MARK: -实现UITableViewDelegate,UITableDataScoure的代理方法
extension PushNewBookViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    //cell 的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "cell")
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        if indexPath.row != 1 {
            cell.accessoryType = .disclosureIndicator
        }
        cell.textLabel?.text = self.titleArray[indexPath.row]
        var row = indexPath.row
        if self.showScore && row > 1 {
            row = row - 1
        }
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = self.bookTitle
            break
        case 2:
            cell.detailTextLabel?.text = self.type + "->" + self.detailType
            break
        case 4:
            //accessoryType cell的样式
            cell.accessoryType = .none
            let commentView = UITextView(frame: CGRect(x: 4, y: 4, width: SCREEN_WIDTH - 8, height: 80))
            commentView.text = self.bookDescription
            cell.contentView.addSubview(commentView)
            break
        default:
            break
        }
        //判断是否需要在第二行添加小星星
        if self.showScore && indexPath.row == 2 {
            cell.contentView.addSubview(self.score!)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showScore && indexPath.row > 5 {
            return 88
        }else if !self.showScore && indexPath.row > 4 {
            return 88
        }else {
            return 44
        }
    }
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        var row = indexPath.row
        if self.showScore && row > 1 {
            row = row - 1
        }
        switch row {
        case 0:
            tableViewSelectTitle()
            break
        case 1:
            tableViewSelectSorce()
            break
        case 2:
            tableViewSelectType()
            break
        case 3:
            tableViewSelectDescription()
            break
        default:
            break
        }

        
        
    }
    /// 选择标题
    @objc func tableViewSelectTitle() {
        let vc = PushSelectTitleViewController()
        GeneralFactory.addTitleWithTitle(target: vc)
        vc.callBack = ({(Title:String)->Void in
            self.bookTitle = Title
            self.tableView?.reloadData()
        })
        self.present(vc, animated: true, completion: nil)
    }
    
    /// 选择评分
    @objc func tableViewSelectSorce() {
        self.tableView?.beginUpdates()
        let tempIndexPath = [NSIndexPath(row: 2, section: 0)]
        
        if self.showScore {
            self.titleArray.remove(at: 2)
            self.tableView?.deleteRows(at: tempIndexPath as [IndexPath], with: .right)
            self.showScore = false
        }else {
            self.titleArray.insert("", at: 2)
            self.tableView?.insertRows(at: tempIndexPath as [IndexPath], with: .left)
            self.showScore = true
        }
        
        
        self.tableView?.endUpdates()
    }
    /// 选择类型
    @objc func tableViewSelectType() {
        let vc =  PushSelectTypeViewController()
        GeneralFactory.addTitleWithTitle(target: vc)
        vc.type = self.type
        vc.detailType = self.detailType
        vc.callBack = ({(type:String, detailType:String) -> Void in
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
        })
        let leftBtn = vc.view.viewWithTag(1001) as? UIButton
        let rigthBtn = vc.view.viewWithTag(1002) as? UIButton
        leftBtn?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        rigthBtn?.setTitleColor(RGB(r: 38, g: 82, b: 67), for: .normal)
        self.present(vc, animated: true, completion: nil)
    }
    /// 选择书评
    @objc func tableViewSelectDescription() {
        let vc = PushSelectDescriptionViewController()
        GeneralFactory.addTitleWithTitle(target: vc)
        vc.callBack = ({(description:String) -> Void in
            self.bookDescription = description
            if self.titleArray.last == "" {
                self.titleArray.removeLast()
            }
            if description != "" {
                self.titleArray.append("")
            }
            self.tableView?.reloadData()
        })
        
        self.present(vc, animated: true, completion: nil)
    }
    
}



