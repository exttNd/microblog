//
//  MainViewController.swift
//  微博
//
//  Created by xm on 2018/3/17.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit


/// 主控制器
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


// MARK: -类似oc中的分类，可以用来切分代码块
extension MainViewController{
    
    /// 初始化子控制器
    func initChildControllers() -> Void {
        
    }
    
    /**
    func getController(dict:[String:String]) -> UIViewController {
       
        guard let clsName = dict["clsclsName"],
             title=dict["title"],
             imageName=dict["imageName"] {
                
            return UIViewController()
        }
        
        let cls = NSClassFormString("") as UIViewController.Type
        let vc=cls.init()
        vc.title=title
        let nav = BaseNavitation
 
    }
    */
}
