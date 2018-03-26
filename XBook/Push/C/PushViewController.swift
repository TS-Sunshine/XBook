//
//  PushViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

class PushViewController: UIViewController {

    //
    var dataArray = NSMutableArray()
    
    var tableView: UITableView?
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
}

extension PushViewController: UITableViewDataSource {
    
}

