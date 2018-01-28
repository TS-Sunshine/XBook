//
//  PhotoPickerViewController.swift
//  XBook
//
//  Created by apple on 2016/10/25.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate {
    func getImageFromPicker(image:UIImage)
}

class PhotoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var alert:UIAlertController?
    
    var picker:UIImagePickerController?
    
    var delegate:PhotoPickerDelegate!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        //背景透明 可以看到下层控制区
        self.modalPresentationStyle = .overFullScreen
        self.view.backgroundColor = UIColor.clear
        
        self.picker = UIImagePickerController()
        self.picker?.allowsEditing = false
        self.picker?.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.alert == nil){
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            self.alert?.addAction(UIAlertAction(title: "打开相册", style: .default, handler: { (UIAlertAction) in
                self.localPhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (UIAlertAction) in
                self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: { 
                    
                })
            }))
            self.present(alert!, animated: true, completion: { 
                
            })
        }
    }
    
    //打开相机
    func takePhoto(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            print("sss")
            self.picker?.sourceType = .camera
            self.present(self.picker!, animated: true, completion: { 
                
            })
            
        }else{
            let alertView = UIAlertController(title: "没有📷拍个屁", message: nil, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: { (UIAlertAction) in
                self.dismiss(animated: true, completion: { 
                    
                })
            }))
            
            self.present(alertView, animated: true, completion: {

            })
        }
    }
    //打开相册
    func localPhoto(){
        
        self.picker?.sourceType = .photoLibrary
        self.present(self.picker!, animated: true) { 
            
        }
    }
    //代理函数
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker?.dismiss(animated: true, completion: { 
            self.dismiss(animated: true, completion: { 
                
            })
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker?.dismiss(animated: true, completion: { 
            self.dismiss(animated: true, completion: { 
                self.delegate.getImageFromPicker(image: image)
            })
        })
        
    }
}
