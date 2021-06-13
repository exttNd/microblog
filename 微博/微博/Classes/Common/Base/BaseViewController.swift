//
//  BaseViewController.swift
//  微博
//
//  Created by xm on 2018/3/17.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit 

class BaseViewController: UIViewController {
     //自定义导航栏
    lazy var navigationBar=UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    lazy var navItem=UINavigationItem()//自定义导航栏条目
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()//初始化视图
    }
 
    
    override var title: String?{
        didSet{
            navItem.title=title
        }
    }

}

extension BaseViewController{

    func initView(){
        
        view.addSubview(navigationBar)//添加自定义导航栏到视图
        navigationBar.items=[navItem]
        //设置navBar 的渲染颜色，解决默认透明度过高导航栏相容问题
        //navigationBar.barTintColor=UIColor.colorWithHex(0xF6F6F6);
        
        var col=UIColor();
        navigationBar.barTintColor=col.tt(0xF6F6F6)

}

}
