//
//  NSAttributedString+Extension.h
//  AliyPay
//
//  Created by maoge on 16/8/11.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)

+ (instancetype)imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

/// 处理单个价格¥ 富文本字符
+ (instancetype)filterOneCharacter:(NSString *)string;

/// 处理两个价格¥ 与 -¥ 富文本字符
+ (instancetype)filterTwoCharacter:(NSString *)string;

/// 处理价格筛选器富文本字符
+ (instancetype)priceSliderString:(NSString *)string;
@end

