//
//  UIBarButtonItem_Extenstions.swift
//  微博
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 xm. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    
    
    convenience init(title:String,fontSize:CGFloat=16,target:AnyObject?,action:Selector?){
        
        let btn:UIButton=UIButton.init()
        btn.setTitle(title, for: .normal) 
        btn.titleLabel?.font=UIFont.systemFont(ofSize: fontSize)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.sizeToFit()
        if let target=target,
            let action=action{
            btn.addTarget(target, action: action, for: .touchUpInside)
        } 
        //self.init 实例化UIBarButtonItem
        self.init(customView: btn)
    }

}


