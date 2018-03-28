//
//  BookDetailViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/3/27.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

class BookDetailViewController: UIViewController,InputViewDelegate,HZPhotoBrowserDelegate {
    
    

    var bookObject: AVObject?
    
    
    
    var BookTitleView:BookDetailView?
    
    var BookViewTabbar:BookTabBar?
    
    var BookTextView:UITextView?
    
    var input:InputView?
    
    var keyBoardHeight:CGFloat = 0.0
    
    var layView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.gray
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:.default)
    
        self.initBookDetailView()
        
        self.BookViewTabbar = BookTabBar(frame: CGRect(x: 0, y: SCREEN_HEIGHT-40, width: SCREEN_WIDTH, height: 40))
        self.BookViewTabbar?.delegate = self
        self.view.addSubview(self.BookViewTabbar!)
        
        self.BookTextView = UITextView(frame: CGRect(x: 0, y: 64+SCREEN_HEIGHT/4, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-SCREEN_HEIGHT/4-40))
        self.BookTextView?.isEditable = false
        self.BookTextView?.text = self.bookObject?["descrption"] as! String
        self.view.addSubview(self.BookTextView!)
        
        self.isLove()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //是否点赞初始化
    func isLove(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current())
        query.whereKey("BookObject", equalTo: self.bookObject!)
        query.findObjectsInBackground { (results, error) in
            if results != nil && results?.count != 0{
                let btn = self.BookViewTabbar?.viewWithTag(2) as? UIButton
                btn?.setImage(UIImage(named:"solidheart"), for: .normal)
            }
        }
    }
    
    
    
    
    //初始化BookDetailView
    func initBookDetailView(){
        self.BookTitleView = BookDetailView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT/4))
        
        let coverFile = self.bookObject?["cover"] as? AVFile
        self.BookTitleView?.cover?.sd_setImage(with: URL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
       
        
        self.BookTitleView?.BookName?.text = "《"+(self.bookObject?["BookName"] as! String)+"》"+(self.bookObject?["title"] as! String)
        self.BookTitleView?.Editor?.text = "作者："+(self.bookObject?["BookEditor"] as! String)
        
        let user = self.bookObject!["user"] as? AVUser
        user?.fetchInBackground({ (returnUser, error) in
            self.BookTitleView?.userName?.text = "编者:" + (returnUser as! AVUser).username!
        })
        
        let date = self.bookObject?["createdAt"] as! Date
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        self.BookTitleView?.date?.text = format.string(from: date)
        
        let scoreString = self.bookObject!["score"] as? String
//        self.BookTitleView?.score?.show_star = Int(scoreString!)!
//        self.BookTitleView?.score?.show_star = (Int(scoreString)!)
//        self.BookTitleView?.more?.text = loveNum.stringValue+"个喜欢，"+disNum.stringValue+"个评论，"+scanNum.stringValue+"次浏览"
        
        let scanNum = self.bookObject?["scanNumber"] as! NSNumber
        let loveNum = self.bookObject?["loveNum"] as! NSNumber
        let disNum = self.bookObject?["disNum"] as! NSNumber
        
        self.BookTitleView?.more?.text = loveNum.stringValue+"个喜欢，"+disNum.stringValue+"个评论，"+scanNum.stringValue+"次浏览"
        
        
        self.view.addSubview(self.BookTitleView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(photo))
        self.BookTitleView?.cover?.addGestureRecognizer(tap)
        self.BookTitleView?.cover?.isUserInteractionEnabled = true
        
        self.bookObject?.incrementKey("scanNumber")
        self.bookObject?.saveInBackground()

    }
    @objc func photo(){
        let photoBrowser = HZPhotoBrowser()
        photoBrowser.imageCount = 1
        photoBrowser.currentImageIndex = 0
        photoBrowser.delegate = self
        photoBrowser.show()
    }
    
    func photoBrowser(_ browser: HZPhotoBrowser!, placeholderImageFor index: Int) -> UIImage! {
        return self.BookTitleView?.cover?.image
    }
    
    func photoBrowser(_ browser: HZPhotoBrowser!, highQualityImageURLFor index: Int) -> URL! {
        let coverFile = self.bookObject?["cover"] as! AVFile
        return NSURL(string: coverFile.url!) as URL!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func keyboardWillHide(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            self.input?.bottom = SCREEN_HEIGHT + (self.input?.height)!
            self.layView?.alpha = 0
        }) { (finish) in
            self.layView?.isHidden = true
        }
    }
    
    func keyboardWillShow(_ inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: TimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animate(withDuration: duration, delay: 0, options: .beginFromCurrentState, animations: {
            self.input?.bottom = SCREEN_HEIGHT - keyboardHeight
            self.layView?.alpha = 0.2
        }) { (finish) in
            
        }
    }
    
    @objc func tapInputView(){
        self.input?.inputTextView.resignFirstResponder()
    }
    
    func textViewHeightDidChange(_ height: CGFloat) {
        self.input?.height = height + 10
        self.input?.bottom = SCREEN_HEIGHT - self.keyBoardHeight
    }
    
    func publishButtonDidClick(_ button: UIButton!) {
        ProgressHUD.show("")
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView.text, forKey: "text")
        object.setObject(AVUser.current(), forKey: "user")
        object.setObject(self.bookObject!, forKey: "BookObject")
        object.saveInBackground { (success, error) in
            if success{
                self.input?.inputTextView.resignFirstResponder()
                self.input?.inputTextView.text = ""
                ProgressHUD.showSuccess("评论成功")
                
                self.bookObject?.incrementKey("disNum")
                self.bookObject?.saveInBackground()
            }else{
                
            }
        }
    }
}





extension BookDetailViewController:BookTabBarDelegate {
    func comment() {
        if self.input == nil {
            self.input = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.last as? InputView
            self.input?.frame = CGRect(x: 0, y: SCREEN_HEIGHT-44, width: SCREEN_WIDTH, height: 44)
            self.input?.delegate = self
            self.view.addSubview(self.input!)
        }
        if self.layView == nil {
            self.layView = UIView(frame: self.view.frame)
            self.layView?.backgroundColor = UIColor.gray
            self.layView?.alpha = 0
            let tap = UITapGestureRecognizer(target: self, action:#selector(self.tapInputView))
            self.layView?.addGestureRecognizer(tap)
        }
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        self.layView?.isHidden = false
        self.input?.inputTextView.becomeFirstResponder()
    }
    
    func commentController() {
        let vc = CommentViewController()
        GeneralFactory.addTitleWithTitle(target: vc,leftTitle: "",rightTitle: "关闭")
        vc.BookObject = self.bookObject
        vc.tableView?.mj_header.beginRefreshing()
        self.present(vc, animated: true) {
            
        }
        
    }
    
    func likeBook(btn: UIButton) {
        //不让btn被重复点击
        btn.isEnabled = false
        btn.setImage(UIImage(named:"redheart"), for: .normal)
        
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.current())
        query.whereKey("BookObject", equalTo: self.bookObject!)
        query.findObjectsInBackground { (results, error) in
            if results != nil && results?.count != 0{
                for object in results!{
                    let love = object as? AVObject
                    love?.deleteEventually()
                    btn.setImage(UIImage(named:"heart"), for: .normal)
                }
                self.bookObject?.incrementKey("loveNum", byAmount: NSNumber(value: -1))
                self.bookObject?.saveInBackground()
            }else{
                let object = AVObject(className: "Love")
                object.setObject(AVUser.current(), forKey: "user")
                object.setObject(self.bookObject, forKey: "BookObject")
                object.saveInBackground({ (success, error) in
                    if success{
                        btn.setImage(UIImage(named:"solidheart"), for: .normal)
                        self.bookObject?.incrementKey("loveNum", byAmount: NSNumber(value: 1))
                        self.bookObject?.saveInBackground()
                    }else{
                        ProgressHUD.showError("操作失败")
                    }
                })
            }
            btn.isEnabled = true
        }
    }
    
    func shareAction() {
         print("4")
    }
    
    
}


