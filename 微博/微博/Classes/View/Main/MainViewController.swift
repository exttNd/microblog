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

         initChildControllers()//初始化所有自控制器
         setupComposeButton()//设置中间的+号按钮
    }
    
    //中间+号按钮点击
    @objc func onComposeButtonClick() {
        
    }

}


// MARK: -类似oc中的分类，可以用来切分代码块
extension MainViewController{
    
    /// 初始化子控制器
    func initChildControllers() -> Void {
        let array=[
             ["clsName":"HomeViewController","title":"首页","imageName":"tabbar_home"],
             ["clsName":"DiscoverViewController","title":"发现","imageName":"tabbar_discover"],
             ["clsName":"UIViewController"],//中间的撰写按钮 占位
             ["clsName":"MessageViewController","title":"消息","imageName":"tabbar_message_center"],
             ["clsName":"ProfileViewController","title":"我","imageName":"tabbar_profile"]
        ]
        
        var childControllerList=[UIViewController]()
        for dict in array{
            childControllerList.append(getController(dict: dict))
        }
        
        viewControllers=childControllerList//
    }
    
    //创建一个带有导航控制器
    func getController(dict:[String:String]) -> UIViewController {
       
        guard let clsName = dict["clsName"],
                  let title = dict["title"],
                  let imageName = dict["imageName"],
                  //利用反射取到VC class类
                  let cls = NSClassFromString(Bundle.main.namespace+"."+clsName) as? UIViewController.Type
                 else {
                
            return UIViewController()
        }
        
        let vc=cls.init()
        vc.title=title
        vc.tabBarItem.image=UIImage(named: imageName)
        vc.tabBarItem.selectedImage=UIImage(named: imageName+"_highlighted")?.withRenderingMode(.alwaysOriginal)//设置渲染模式
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)//设置选中字体颜色
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)//设置字体大小
        let nav = BaseNavigationController(rootViewController:vc)

        return nav
    }
    
    //设置撰写按钮
    func setupComposeButton() {
        let btn:UIButton=UIButton()
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
        
        let count=CGFloat(childViewControllers.count)
        let w=tabBar.bounds.width/count - 1//减一是为了遮盖容错点
        btn.frame=tabBar.bounds.insetBy(dx: w*2, dy: 0)
        
        tabBar.addSubview(btn)
        //添加监听方法
        btn.addTarget(self, action:#selector(onComposeButtonClick), for: .touchUpInside)
        
    }

}
