//
//  UIView+view.m
//  fenlei
//
//  Created by hu on 15/5/13.
//  Copyright (c) 2015年 hu. All rights reserved.
//

#import "UIView+view.h"
#import <objc/runtime.h>
#import "UIColor+ColorValue.h"
static char _backColor[] = "a";


@implementation UIView (view)
-(void)setBackColor:(NSString *)backColor
{
    objc_setAssociatedObject(self, _backColor, backColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString*)backColor
{
    return objc_getAssociatedObject(self, _backColor);
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    self.layer.shouldRasterize = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}



@end
