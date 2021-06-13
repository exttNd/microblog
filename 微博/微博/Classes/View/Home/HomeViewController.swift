//
//  HomeViewController.swift
//  微博
//
//  Created by xm on 2018/3/17.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.red         
        
    }
    
    
    override func initView() {
        super.initView()
        
         navItem.leftBarButtonItem=UIBarButtonItem.init(title: "好友", target: nil, action:nil)
    }
    
}

 
