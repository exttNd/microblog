//
//  UIColor+Category.m
//  微博
//
//  Created by admin on 2018/3/19.
//  Copyright © 2018年 xm. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)


+ (UIColor *)red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
+ (NSArray *)convertColorToRGB:(UIColor *)color {
    NSInteger numComponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *array = nil;
    if (numComponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        array = @[@((int)(components[0] * 255)),
                  @((int)(components[1] * 255)),
                  @((int)(components[2] * 255))];
    }
    return array;
}

- (UIColor *)tt:(NSInteger)hex {
    return [UIColor colorWithRed:((float)((hex & 0xff0000) >> 16))/255.0 green:((float)((hex & 0x00ff00) >> 8))/255.0 blue:((float)(hex & 0x0000ff))/255.0 alpha:1.0];
}


+ (UIColor *)colorWithHex:(NSInteger)hex {
    return [UIColor colorWithRed:((float)((hex & 0xff0000) >> 16))/255.0 green:((float)((hex & 0x00ff00) >> 8))/255.0 blue:((float)(hex & 0x0000ff))/255.0 alpha:1.0];
}
+(UIColor *) colorWithHexString: (NSString *) hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            blue=0;
            green=0;
            red=0;
            alpha=0;
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+(CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}


@end
