//
//  PushSelectTypeViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/5.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit
//
typealias pushTypeControllerBlock = (_ type:String, _ detailType:String) -> Void

class PushSelectTypeViewController: UIViewController {
    
    var segmentController1:AKSegmentedControl?
    var segmentController2:AKSegmentedControl?
    
    var literatureArray1:Array<NSDictionary> = []
    var literatureArray2:Array<NSDictionary> = []
    
    var humanitiesArray1:Array<NSDictionary> = []
    var humanitiesArray2:Array<NSDictionary> = []
    
    var livelihoodArray1:Array<NSDictionary> = []
    var livelihoodArray2:Array<NSDictionary> = []
    
    var economiesArray1:Array<NSDictionary> = []
    var economiesArray2:Array<NSDictionary> = []
    
    var technologyArray1:Array<NSDictionary> = []
    var technologyArray2:Array<NSDictionary> = []
    
    var networkArray1:Array<NSDictionary> = []
    var networkArray2:Array<NSDictionary> = []
    
    var dropDownMenu1:IGLDropDownMenu?
    var dropDownMenu2:IGLDropDownMenu?
    
    var callBack:pushTypeControllerBlock?
    
    var type = ""
    var detailType = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        let segmentLabel = UILabel(frame: CGRect(x: (SCREEN_WIDTH - 300) / 2 , y: 20, width: 300, height: 20))
        segmentLabel.text = "请选择分类"
        segmentLabel.shadowOffset = CGSize(width: 0, height: 1)
        segmentLabel.shadowColor = UIColor.white
        segmentLabel.textColor = RGB(r: 82, g: 113, b: 131)
        segmentLabel.textAlignment = .center
        self.view.addSubview(segmentLabel)
        
        initSegment()
        self.initDropArray()
        self.createDropMenu(array1: self.literatureArray1, array2: self.literatureArray2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sure() {
        self.callBack!(self.type, self.detailType)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// 初始化segment
    func initSegment() {
        let buttonArray1 = [
            ["image":"ledger", "title":"文学"],
            ["image":"ledger", "title":"人文社科"],
            ["image":"ledger", "title":"生活"],
        ]
        self.segmentController1 = AKSegmentedControl(frame: CGRect(x: 10, y: 60, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentController1?.initButton(withTitleandImage: buttonArray1)
        self.view.addSubview(self.segmentController1!)
        
        let buttonArray2 = [
            ["image":"ledger", "title":"经管"],
            ["image":"ledger", "title":"科技"],
            ["image":"ledger", "title":"网络流行"],
        ]
        self.segmentController2 = AKSegmentedControl(frame: CGRect(x: 10, y: 110, width: SCREEN_WIDTH - 20, height: 37))
        self.segmentController2?.initButton(withTitleandImage: buttonArray2)
        self.view.addSubview(self.segmentController2!)
        
        self.segmentController1?.addTarget(self, action: #selector(segmentControllerAction(segment:)), for: .valueChanged)
        self.segmentController2?.addTarget(self, action: #selector(segmentControllerAction(segment:)), for: .valueChanged)
    }
    
    /**
     init Array
     */
    func initDropArray(){
        
        self.literatureArray1 = [
            ["title":"小说"],
            ["title":"漫画"],
            ["title":"青春文学"],
            ["title":"随笔"],
            ["title":"现当代诗"],
            ["title":"戏剧"],
        ];
        self.literatureArray2 = [
            ["title":"传记"],
            ["title":"古诗词"],
            ["title":"外国诗歌"],
            ["title":"艺术"],
            ["title":"摄影"],
        ];
        self.humanitiesArray1 = [
            ["title":"历史"],
            ["title":"文化"],
            ["title":"古籍"],
            ["title":"心理学"],
            ["title":"哲学/宗教"],
            ["title":"政治/军事"],
        ];
        self.humanitiesArray2 = [
            ["title":"社会科学"],
            ["title":"法律"],
        ];
        self.livelihoodArray1 = [
            ["title":"休闲/爱好"],
            ["title":"孕产/胎教"],
            ["title":"烹饪/美食"],
            ["title":"时尚/美妆"],
            ["title":"旅游/地图"],
            ["title":"家庭/家居"],
        ];
        self.livelihoodArray2 = [
            ["title":"亲子/家教"],
            ["title":"两性关系"],
            ["title":"育儿/早教"],
            ["title":"保健/养生"],
            ["title":"体育/运动"],
            ["title":"手工/DIY"],
        ];
        self.economiesArray1  = [
            ["title":"管理"],
            ["title":"投资"],
            ["title":"理财"],
            ["title":"经济"],
        ];
        self.economiesArray2  = [
            ["title":"没有更多了"],
        ];
        self.technologyArray1 =  [
            ["title":"科普读物"],
            ["title":"建筑"],
            ["title":"医学"],
            ["title":"计算机/网络"],
        ];
        self.technologyArray2 = [
            ["title":"农业/林业"],
            ["title":"自然科学"],
            ["title":"工业技术"],
        ];
        self.networkArray1 =    [
            ["title":"玄幻/奇幻"],
            ["title":"武侠/仙侠"],
            ["title":"都市/职业"],
            ["title":"历史/军事"],
        ];
        self.networkArray2 =    [
            ["title":"游戏/竞技"],
            ["title":"科幻/灵异"],
            ["title":"言情"],
        ];
        
    }
    
    //segment的点击动作
    @objc func segmentControllerAction(segment:AKSegmentedControl) {
        var index = segment.selectedIndexes.first
        var i = index! as Int
        self.type = (segment.buttonsArray[index!] as! UIButton).currentTitle!
        if segment == self.segmentController1 {
            self.segmentController2?.setSelectedIndex(3)
        }else {
            self.segmentController1?.setSelectedIndex(3)
            index = index! + 3
        }
        if self.dropDownMenu1 != nil {
            self.dropDownMenu1?.resetParams()
        }
        if self.dropDownMenu2 != nil {
            self.dropDownMenu2?.resetParams()
        }
        
        switch index! {
        case 0:
            self.createDropMenu(array1: self.literatureArray1, array2: self.literatureArray2)
            break
        case 1:
            self.createDropMenu(array1: self.humanitiesArray1, array2: self.humanitiesArray2)
            break
        case 2:
            self.createDropMenu(array1: self.livelihoodArray1, array2: self.livelihoodArray2)
            break
        case 3:
            self.createDropMenu(array1: self.economiesArray1, array2: self.economiesArray2)
            break
        case 4:
            self.createDropMenu(array1: self.technologyArray1, array2: self.technologyArray2)
            break
        case 5:
            self.createDropMenu(array1: self.networkArray1, array2: self.networkArray2)
            break
        default:
            break
        }
        
    }
    
    ///初始化dropDownMenu
    func createDropMenu(array1:Array<NSDictionary>, array2:Array<NSDictionary>) {
        let dropDownItem1 = NSMutableArray()
        for i in 0 ..< array1.count {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as! String
            dropDownItem1.add(item)
        }
        let dropDownItem2 = NSMutableArray()
        for i in 0 ..< array2.count {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as! String
            dropDownItem2.add(item)
        }
        
        self.dropDownMenu1?.removeFromSuperview()
        self.dropDownMenu1 = IGLDropDownMenu()
        self.dropDownMenu1?.menuText = "点击展开详细列表"
        self.dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu1?.menuButton.textLabel.textColor = RGB(r: 30, g: 82, b: 67)
        self.dropDownMenu1?.paddingLeft = 15
        self.dropDownMenu1?.delegate = self
        self.dropDownMenu1?.type = .stack
        self.dropDownMenu1?.itemAnimationDelay = 0.1
        self.dropDownMenu1?.gutterY = 5
        self.dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        self.dropDownMenu1?.frame = CGRect(x: 20, y: 150, width: SCREEN_WIDTH/2-30, height: (SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu1!)
        self.dropDownMenu1?.reloadView()
        
        self.dropDownMenu2?.removeFromSuperview()
        self.dropDownMenu2 = IGLDropDownMenu()
        self.dropDownMenu2?.menuText = "点击展开详细列表"
        self.dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu2?.menuButton.textLabel.textColor = RGB(r: 30, g: 82, b: 67)
        self.dropDownMenu2?.paddingLeft = 15
        self.dropDownMenu2?.delegate = self
        self.dropDownMenu2?.type = .stack
        self.dropDownMenu2?.itemAnimationDelay = 0.1
        self.dropDownMenu2?.gutterY = 5
        self.dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        self.dropDownMenu2?.frame = CGRect(x: SCREEN_WIDTH/2+10, y: 150, width: SCREEN_WIDTH/2-30, height: (SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu2!)
        self.dropDownMenu2?.reloadView()
    }
    

}




extension PushSelectTypeViewController:IGLDropDownMenuDelegate {
    func dropDownMenu(_ dropDownMenu: IGLDropDownMenu!, selectedItemAt index: Int) {
        if dropDownMenu == self.dropDownMenu1{
            let item = self.dropDownMenu1?.dropDownItems[index] as! IGLDropDownItem
            self.detailType = item.text
            self.dropDownMenu2?.menuButton.text = self.detailType
        }else{
            let item = self.dropDownMenu2?.dropDownItems[index] as! IGLDropDownItem
            self.detailType = item.text
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
    }
    
    
}
