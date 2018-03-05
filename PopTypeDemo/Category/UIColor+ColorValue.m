//
//  UIColor+ColorValue.m
//  类别添加属性
//
//  Created by sny on 15/5/4.
//  Copyright (c) 2015年 sny. All rights reserved.
//

#import "UIColor+ColorValue.h"

@implementation UIColor (ColorValue)

+(instancetype)colorWithValue:(NSString *)stringToConvert
{
    return [self colorWithValue:stringToConvert alpha:1.f];
}

+(instancetype)colorWithValue:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor blackColor];
    }
    
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
    
}

@end
