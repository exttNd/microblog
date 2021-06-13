//
//  BaseNavigationController.swift
//  微博
//
//  Created by xm on 2018/3/17.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)//隐藏系统自带的导航栏（子VC中自定义）
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed=true;//当第二级页面时隐藏导航栏
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
