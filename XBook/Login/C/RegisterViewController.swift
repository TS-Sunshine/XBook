//
//  RegisterViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/9.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerView.frame = self.view.bounds
        self.view.addSubview(registerView)
        // Do any additional setup after loading the view.
        
        self.registerView.closeRegisterViewButton?.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        self.registerView.registerButton?.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func registerAction() {
        let user = AVUser()
       
        user.username = self.registerView.accountNumberTextField?.text
        
        user.password = self.registerView.passwordTextField?.text
        
        user.email = self.registerView.emailTextField?.text
      /**
        if user.signUp().isSuccess {
            ProgressHUD.showSuccess("注册成功,请登录!")
            self.dismiss(animated: true, completion: nil)
        }else if user.signUp().error?.code == 125 {
            ProgressHUD.showError("邮箱不合法")
        }else if user.signUp().error?.code == 203 {
            ProgressHUD.showError("该邮箱已注册")
            
        }else if user.signUp().error?.code == 202 {
            ProgressHUD.showError("用户名已存在")
        }else {
            ProgressHUD.showError("注册失败 ")
        }
    */
        user.signUpInBackground { (success, error) in
            if success{
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismiss(animated: true, completion: {
                    
                })
            }else{
                let e = error! as NSError
                if e.code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if e.code == 203 {
                    ProgressHUD.showError("该邮箱已注册")
                }else if e.code == 202 {
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            }
        }
    }


}
