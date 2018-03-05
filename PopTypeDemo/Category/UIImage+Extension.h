//
//  UIImage+Extension.h
//
//
//  Created by maoge on 16/9/8.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//等比例绘制缩放
- (instancetype)scaleToWidth:(CGFloat)width;

- (instancetype)scaleToWidth:(CGFloat)width height:(CGFloat)height;

//等比例大小缩放
- (CGSize)scaleOriginalImageWidth:(CGFloat )imageWidth height:(CGFloat)imageHeight;

//图片异步绘制
- (void)jq_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *img))completion;

//根据颜色绘制图片
+ (UIImage *)jq_imageWithColor:(UIColor *)color size:(CGSize)size;

@end
