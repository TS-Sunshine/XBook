//
//  LoginView.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/9.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var LogoImageView:UIImageView?
    
    var accountNumberTextField:UITextField?
    
    var passwordTextField:UITextField?
    
    var loginButton:UIButton?
    
    var registerButton:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white

        setupSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///初始化控件
    func setupSubview() {
        // Logo
        self.LogoImageView = UIImageView()
        self.LogoImageView?.image = UIImage(named: "login")
        self.addSubview(self.LogoImageView!)
        // 账号输入框
        self.accountNumberTextField = UITextField()
        self.accountNumberTextField?.placeholder = "请输入账号"
        self.addSubview(self.accountNumberTextField!)
        // 密码输入框
        self.passwordTextField = UITextField()
        self.passwordTextField?.placeholder = "请输入密码"
        self.passwordTextField?.isSecureTextEntry = true
        self.addSubview(self.passwordTextField!)
        
        self.loginButton = UIButton()
        self.loginButton?.setTitle("登录", for: .normal)
        self.loginButton?.setTitleColor(UIColor.black, for: .normal)
        self.loginButton?.titleLabel?.textAlignment = .center
        self.addSubview(self.loginButton!)
        
        self.registerButton = UIButton()
        self.registerButton?.setTitle("新用户注册", for: .normal)
        self.registerButton?.setTitleColor(UIColor.black, for: .normal)
        self.registerButton?.titleLabel?.textAlignment = .center
        self.addSubview(self.registerButton!)
        
    }
    
    override func layoutSubviews() {
        let LogoImageViewFrame = CGRect(x: 20, y: 8, width: 200, height: 200)
        self.LogoImageView?.frame = LogoImageViewFrame
        
        let accountNumberTextFieldFrame = CGRect(x: 20, y: 230, width: 280, height: 30)
        self.accountNumberTextField!.frame = accountNumberTextFieldFrame
        
        let passwordTextFieldFrame = CGRect(x: 20, y: 270, width: 280, height: 30)
        self.passwordTextField!.frame = passwordTextFieldFrame
        
        let loginButtonFrame = CGRect(x: 20, y: 310, width: 280, height: 30)
        self.loginButton?.frame = loginButtonFrame
        
        let registerButtonFrame = CGRect(x: 40, y: 250, width: 140, height: 30)
        self.registerButton?.frame = registerButtonFrame
        
        
        
        
        
        
    }

}
