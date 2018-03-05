//
//  NSAttributedString+Extension.m
//  AliyPay
//
//  Created by maoge on 16/8/11.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (instancetype)imageTextWithImage:(UIImage *)image imageWH:(CGFloat)imageWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    
    
    //空格
    NSAttributedString *space = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:spacing]}];
    //文字
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : titleColor, NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}];
    
    
    
    //图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    
    NSAttributedString *attStr2 = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] init];
    
    [attM appendAttributedString:attStr2];
    [attM appendAttributedString:space];
    [attM appendAttributedString:attStr];
    
    return attM.copy;
}

+ (instancetype)filterOneCharacter:(NSString *)string{
    
    NSRange firstCharacter = [string rangeOfString:@"¥"];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor colorWithValue:@"666666"], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} range:firstCharacter];
    
    return [attStr copy];
}

+ (instancetype)filterTwoCharacter:(NSString *)string{
    
    NSRange firstCharacter = [string rangeOfString:@"¥"];
    NSRange secondCharacter = [string rangeOfString:@"-¥"];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor colorWithValue:@"666666"], NSFontAttributeName : [UIFont systemFontOfSize:15]}];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} range:firstCharacter];
    
    [attStr addAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:13]} range:secondCharacter];
    
    return [attStr copy];
}


+ (instancetype)priceSliderString:(NSString *)string{
    NSRange firstCharacter = [string rangeOfString:@"¥"];
    NSRange secondCharacter = [string rangeOfString:@"-¥"];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : [UIColor colorWithValue:@"ff2e5a"], NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} range:firstCharacter];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} range:NSMakeRange(secondCharacter.location + 1, secondCharacter.length - 1)];
    
    return [attStr copy];
    
}
@end
