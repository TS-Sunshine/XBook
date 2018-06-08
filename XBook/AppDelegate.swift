//
//  AppDelegate.swift
//  XBook
//
//  Created by 安静的为你歌唱 on 2017/12/11.
//  Copyright © 2017年 安静地为你歌唱. All rights reserved.
//

import UIKit
import AVOSCloud
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //初始化LeanCloud
//        LeanCloud.initialize(applicationID: "jww4GxVHxznsqVmDwwv0s85s-gzGzoHsz", applicationKey: "t5YTTKjMpbDxybCuEjU8PKet")

        AVOSCloud.setApplicationId("jww4GxVHxznsqVmDwwv0s85s-gzGzoHsz", clientKey: "t5YTTKjMpbDxybCuEjU8PKet")
        
        let mainTabBar = UITabBarController()
        //创建主窗口
        self.window = UIWindow(frame:UIScreen.main.bounds)
        //创建各个控制器
        let rankViewController = UINavigationController.init(rootViewController: RankViewController())
        let seachViewController = UINavigationController.init(rootViewController: SearchViewController())
        let pushViewController = UINavigationController.init(rootViewController: PushViewController())
        let circleViewController = UINavigationController.init(rootViewController: CircleViewController())
        let moreViewController = UINavigationController.init(rootViewController: MoreViewController())
        

        //将各个控制器添加
        mainTabBar.viewControllers = [rankViewController, seachViewController, pushViewController, circleViewController, moreViewController]
        
        let rankTabBarItem = UITabBarItem(title: "排行榜", image: UIImage.init(named: "bio_red"), selectedImage: UIImage.init(named: "bio_red"))
        let searchTabBarItem = UITabBarItem(title: "发现", image: UIImage.init(named: "timer2"), selectedImage: UIImage.init(named: "timer2_red"))
        let pushTabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "pencil"), selectedImage: UIImage.init(named: "pencil_red"))
        let circleTabBarItem = UITabBarItem(title: "圈子", image: UIImage.init(named: "users two-2"), selectedImage: UIImage.init(named: "users two-2_red"))
        let moreTabBarItem = UITabBarItem(title: "更多", image: UIImage.init(named: "more"), selectedImage: UIImage.init(named: "more_red"))
        
        
        rankViewController.tabBarItem = rankTabBarItem
        seachViewController.tabBarItem = searchTabBarItem
        pushViewController.tabBarItem = pushTabBarItem
        circleViewController.tabBarItem = circleTabBarItem
        moreViewController.tabBarItem = moreTabBarItem
        
        rankViewController.tabBarController?.tabBar.tintColor = MAIN_blue
        
        self.window?.rootViewController = mainTabBar
        self.window?.makeKeyAndVisible()
        
        
        
        
        
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    


}

