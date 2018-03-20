//
//  LoginViewController.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/9.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud

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
        AVUser.logInWithUsername(inBackground: (self.loginView.accountNumberTextField?.text)! , password: (self.loginView.passwordTextField?.text)!) { (user, error) in
            if error == nil {
                self.dismiss(animated: true, completion: {
                    let savePassword = UserDefaults.standard
                    savePassword.set((self.loginView.passwordTextField?.text)!, forKey: "password")
                })
            }else{
                let e = error! as NSError
                if e.code == 210{
                    ProgressHUD.showError("用户名或密码错误")
                }else if e.code == 211{
                    ProgressHUD.showError("不存在该用户")
                }else if e.code == 216{
                    ProgressHUD.showError("未验证邮箱")
                }else if e.code == 1{
                    ProgressHUD.showError("操作频繁")
                }else{
                    ProgressHUD.showError("登录失败")
                }
            }
        }
    }
}
