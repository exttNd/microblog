//
//  UIColor+Category.h
//  微博
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 xm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

//设置RGB颜色
+ (UIColor *)red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;
//将颜色转换成RGB
+ (NSArray *)convertColorToRGB:(UIColor *)color;
//设置十六进制颜色
+ (UIColor *)colorWithHex:(NSInteger)hex;
+ (UIColor*)colorWithHexString:(NSString *)hexString;

-(UIColor *)tt:(NSInteger)hex;

@end
