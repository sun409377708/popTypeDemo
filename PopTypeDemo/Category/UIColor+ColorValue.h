//
//  UIColor+ColorValue.h
//  类别添加属性
//
//  Created by sny on 15/5/4.
//  Copyright (c) 2015年 sny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorValue)
/**
 将16进制颜色值转化成UIColor   #F2F2F2 -> UIColor
 */
+(instancetype)colorWithValue:(NSString *)colorValue;

+(instancetype)colorWithValue:(NSString *)colorValue alpha:(CGFloat)alpha;

@end
