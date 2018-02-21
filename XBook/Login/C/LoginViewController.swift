//
//  LoginViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/9.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit
import LeanCloud

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.frame = self.view.bounds
        
        self.view.addSubview(self.loginView)
        
        self.loginView.registerButton?.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        
        self.loginView.loginButton?.addTarget(self, action: #selector(loginAction), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func registerButtonAction() {
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)
    }
    
    @objc func loginAction() {
        var result = LCUser.logIn(username: (self.loginView.accountNumberTextField?.text)!, password: (self.loginView.passwordTextField?.text)!)
        
        if result.isSuccess {
            ProgressHUD.showSuccess("登录成功")
            self.dismiss(animated: true, completion: nil)
        }else if result.error?.code == 210 {
            ProgressHUD.showError("用户名或密码错误")
        }else if result.error?.code == 211 {
            ProgressHUD.showError("不存在改用户")
        }else if result.error?.code == 216 {
            ProgressHUD.showError("未验证邮箱")
        }else if result.error?.code == 1 {
            ProgressHUD.showError("操作频繁")
        }else {
            ProgressHUD.showError("登录失败")
        }
    }
}
