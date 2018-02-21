//
//  RegisterView.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2018/2/9.
//  Copyright © 2018年 安静地为你歌唱. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    
    var LogoImageView:UIImageView?
    
    var accountNumberTextField:UITextField?
    
    var emailTextField:UITextField?
 
    var passwordTextField:UITextField?
    
    var registerButton:UIButton?
    
    var closeRegisterViewButton:UIButton?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        // Logo
        self.LogoImageView = UIImageView()
        self.LogoImageView?.image = UIImage(named: "login")
        self.addSubview(self.LogoImageView!)
        // 账号输入框
        self.accountNumberTextField = UITextField()
        self.accountNumberTextField?.placeholder = "请输入账号"
        self.addSubview(self.accountNumberTextField!)
        
        self.emailTextField = UITextField()
        self.emailTextField?.placeholder = "请输入邮箱"
        self.addSubview(self.emailTextField!)
        // 密码输入框
        self.passwordTextField = UITextField()
        self.passwordTextField?.placeholder = "请输入密码"
        self.passwordTextField?.isSecureTextEntry = true
        self.addSubview(self.passwordTextField!)
        
        self.registerButton = UIButton()
        self.registerButton?.setTitle("注册", for: .normal)
        self.registerButton?.setTitleColor(UIColor.black, for: .normal)
        self.registerButton?.titleLabel?.textAlignment = .center
        self.addSubview(self.registerButton!)
        
        self.closeRegisterViewButton = UIButton()
        self.closeRegisterViewButton?.setTitle("取消", for: .normal)
        self.closeRegisterViewButton?.setTitleColor(UIColor.black, for: .normal)
        self.closeRegisterViewButton?.titleLabel?.textAlignment = .center
        self.addSubview(self.closeRegisterViewButton!)
    }
    
    override func layoutSubviews() {
        let LogoImageViewFrame = CGRect(x: 20, y: 8, width: 200, height: 200)
        self.LogoImageView?.frame = LogoImageViewFrame
        
        let accountNumberTextFieldFrame = CGRect(x: 20, y: 230, width: 280, height: 30)
        self.accountNumberTextField!.frame = accountNumberTextFieldFrame
        
        let emailTextFieldFrame = CGRect(x: 20, y: 350, width: 280, height: 30)
        self.emailTextField?.frame = emailTextFieldFrame
        
        let passwordTextFieldFrame = CGRect(x: 20, y: 270, width: 280, height: 30)
        self.passwordTextField!.frame = passwordTextFieldFrame
        
        let registerButtonFrame = CGRect(x: 20, y: 310, width: 280, height: 30)
        self.registerButton?.frame = registerButtonFrame
        
        let closeRegisterViewButtonFrame = CGRect(x: 20, y: 20, width: 40, height: 30)
        self.closeRegisterViewButton?.frame = closeRegisterViewButtonFrame
    }
}
