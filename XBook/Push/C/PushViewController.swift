//
//  PushViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

class PushViewController: UIViewController,SWTableViewCellDelegate {
    var navigationView:UIView?
    //
    var dataArray = NSMutableArray()
    
    var tableView: UITableView?
    
    var swipeCell:IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.title = "新建书评"
        
        self.setNavigationBar()
       
        self.tableView = UITableView(frame: self.view.frame)
        
        self.tableView?.delegate = self
        
        self.tableView?.dataSource = self
        
        self.view.addSubview(self.tableView!)
        
        self.tableView?.register(PushBookCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationView?.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationView?.isHidden = true
    }
    
    /// 新建书评
    func setNavigationBar(){
        //创建navigationbar
        navigationView = UIView(frame:CGRect(x:0,y:-20,width:SCREEN_WIDTH,height:64))
        navigationView?.backgroundColor = MAIN_blue
        
        self.navigationController?.navigationBar.addSubview(navigationView!)
        
        //
        let addNavigationBarBtn = UIButton.init(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH, height: 45))
        addNavigationBarBtn.setImage(UIImage(named:"plus circle"), for:.normal)
        addNavigationBarBtn.setTitle("   新建书评", for: .normal)
        addNavigationBarBtn.setTitleColor(UIColor.black, for: .normal)
        addNavigationBarBtn.contentHorizontalAlignment = .left
        addNavigationBarBtn.addTarget(self, action: #selector(pushNewBook), for: .touchUpInside)
        navigationView?.addSubview(addNavigationBarBtn)
    }
    
    @objc func pushNewBook(){
        let vc = PushNewBookViewController()
//        GeneralFactory.addTitleWithTitle(target: vc, title1:"返回", title2:"发布")
        GeneralFactory.addTitleWithTitle(target: vc, leftTitle: "返回", rightTitle: "发布")
        self.present(vc, animated: true) {
        }
    }
    
    
    /// 上拉刷新
    @objc func headerRefresh() {
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (result, error) in
            self.tableView?.mj_header.endRefreshing()
            
            self.dataArray.removeAllObjects()
            
            self.dataArray.addObjects(from: result!)
            
            self.tableView?.reloadData()
        }
    }
    
    
    /// 下拉加载
    @objc func footerRefresh() {
        let query = AVQuery(className: "Book")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.current())
        query.findObjectsInBackground { (result, error) in
            self.tableView?.mj_header.endRefreshing()
            
            self.dataArray.addObjects(from: result!)
            
            self.tableView?.reloadData()
        }
    }
   
}

extension PushViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PushBookCell
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        
        cell.rightUtilityButtons = self.returnRightBtn()
        cell.delegate = self
        
        cell.bookName?.text = "《" + (dict!["BookName"] as! String) + "》:" + (dict!["title"] as! String)
        
        cell.editor?.text = "作者："+(dict!["BookEditor"] as! String)
        
        let date = dict!["createdAt"] as! NSDate
        
        let format = DateFormatter()
        
        format.dateFormat = "yyyy-MM-dd hh:mm"
        
        cell.more?.text = format.string(from: date as Date)
        
        let coverFile = dict?["cover"] as! AVFile
        
        cell.coverImageView?.sd_setImage(with: URL(string: (coverFile.url)!), placeholderImage: UIImage(named: "Cover"))
        
//        cell.coverImageView?.sd_setImage(with: coverFile.url, placeholderImage: UIImage(named: "Cover"))
        
        
        return cell
    }
    
    
    func returnRightBtn()->[AnyObject]{
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn1.backgroundColor = UIColor.orange
        btn1.setTitle("编辑", for: .normal)
        
        let btn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 88, height: 88))
        btn2.backgroundColor = UIColor.red
        btn2.setTitle("删除", for: .normal)
        return [btn1,btn2]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.bookObject = self.dataArray[indexPath.row] as! AVObject
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    //SWTableViewCellDelegate
    func swipeableTableViewCell(_ cell: SWTableViewCell!, scrollingTo state: SWCellState) {
        let indexPath = self.tableView?.indexPath(for: cell)
        if state == .cellStateRight{
            if self.swipeCell != nil && self.swipeCell?.row != indexPath?.row {
                let swipedCell = self.tableView?.cellForRow(at: self.swipeCell!) as? PushBookCell
                swipedCell?.hideUtilityButtons(animated: true)
            }
            self.swipeCell = indexPath
        }else if state == .cellStateCenter{
            self.swipeCell = nil
        }
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        cell.hideUtilityButtons(animated: true)
        
        let indexPath = self.tableView?.indexPath(for: cell)
        
        let object = self.dataArray[(indexPath?.row)!] as? AVObject
        
        if index == 0 {
            let vc = PushNewBookViewController()
            GeneralFactory.addTitleWithTitle(target: vc, leftTitle: "关闭", rightTitle: "发布")
            
            vc.fixType = "fix"
            vc.BookObject = object
            vc.fixBook()
            self.present(vc, animated: true, completion: {
                
            })
        }else{
            ProgressHUD.show("")
            
            let disscussQuery = AVQuery(className: "discuss")
            disscussQuery.whereKey("BookObject", equalTo: object!)
            disscussQuery.findObjectsInBackground({ (results, error) in
                for Book in results! {
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            let loveQuery = AVQuery(className: "Love")
            loveQuery.whereKey("BookObject", equalTo: object!)
            loveQuery.findObjectsInBackground({ (results, error) in
                for Book in results! {
                    let BookObject = Book as? AVObject
                    BookObject?.deleteInBackground()
                }
            })
            
            object?.deleteInBackground({ (success, error) in
                if success{
                    ProgressHUD.showSuccess("删除成功")
                    self.dataArray.removeObject(at: (indexPath?.row)!)
                    self.tableView?.reloadData()
                }else{
                    
                }
            })
        }
    }
}

// MARK: - <#UITableViewDataSource#>
extension PushViewController: UITableViewDataSource {
    
}

