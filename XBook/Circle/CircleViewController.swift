//
//  CircleViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

class CircleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArray = NSMutableArray()
    var tableView:UITableView?
    var navigationView:UIView?
    var swipeCell:IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView?.mj_header.beginRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "圈子"
        self.view.backgroundColor = UIColor.white
        
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        self.tableView?.register(PushBookCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.headerRefresh))
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.footerRefresh))
        self.navigationController?.navigationBar.barTintColor = MAIN_blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationView?.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationView?.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //uitableview代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PushBookCell
        
        //        cell?.rightUtilityButtons = self.returnRightBtn()
        //        cell?.delegate = self
        
        let dict = self.dataArray[indexPath.row] as? AVObject
        cell?.bookName?.text = "《"+(dict?["BookName"] as! String)+"》"+(dict?["title"] as! String)
        cell?.editor?.text = "作者："+(dict?["BookEditor"] as! String)
        
        let date = dict?["createdAt"] as! Date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.more?.text = format.string(from: date)
        
        let coverFile = dict?["cover"] as! AVFile
        cell?.coverImageView?.sd_setImage(with: URL(string: (coverFile.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.bookObject = self.dataArray[indexPath.row] as? AVObject
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //上拉加载 下拉刷新
    @objc func headerRefresh(){
        let loveArr = NSMutableArray()
        let LoveQuery = AVQuery(className: "Love")
        LoveQuery.order(byDescending: "createdAt")
        LoveQuery.limit = 20
        LoveQuery.skip = 0
        LoveQuery.whereKey("user", equalTo: AVUser.current())
        LoveQuery.includeKey("BookObject")
        LoveQuery.findObjectsInBackground { (results, error) in
            loveArr.addObjects(from: results!)
            self.tableView?.mj_header.endRefreshing()
            self.dataArray.removeAllObjects()
            for object in loveArr {
                let loveObject = object as? AVObject
                let bookObject = loveObject?["BookObject"] as! AVObject
                self.dataArray.add(bookObject)
            }
            self.tableView?.reloadData()
        }
    }
    
    @objc func footerRefresh(){
        let loveArr = NSMutableArray()
        let LoveQuery = AVQuery(className: "Love")
        LoveQuery.order(byDescending: "createdAt")
        LoveQuery.limit = 20
        LoveQuery.skip = self.dataArray.count
        LoveQuery.whereKey("user", equalTo: AVUser.current())
        LoveQuery.includeKey("BookObject")
        LoveQuery.findObjectsInBackground { (results, error) in
            loveArr.addObjects(from: results!)
            self.tableView?.mj_footer.endRefreshing()
            for object in loveArr {
                let loveObject = object as? AVObject
                let bookObject = loveObject?["BookObject"] as! AVObject
                self.dataArray.add(bookObject)
            }
            self.tableView?.reloadData()
        }
    }
    
}
