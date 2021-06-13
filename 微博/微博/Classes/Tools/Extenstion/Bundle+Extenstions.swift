//
//  Bundle+Extenstions.swift
//  微博
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 xm. All rights reserved.
//

import Foundation

extension Bundle{
  
    //计算型属性
    //计算型属性属于函数，没有参数，有返回值
    var namespace:String{
        //return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
