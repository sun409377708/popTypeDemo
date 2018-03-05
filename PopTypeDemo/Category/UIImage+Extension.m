//
//  UIImage+Extension.m
//  生活圈story
//
//  Created by maoge on 16/9/8.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (instancetype)scaleToWidth:(CGFloat)width {
    
    if (self.size.width < width) {
        return self;
    }
    
    CGFloat height = width / self.size.width * self.size.height;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //开启
    UIGraphicsBeginImageContext(rect.size);
    
    //绘图
    [self drawInRect:rect];
    
    
    //取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (instancetype)scaleToWidth:(CGFloat)width height:(CGFloat)height {
    
    CGSize size = [self scaleOriginalImageWidth:width height:height];
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //开启
    UIGraphicsBeginImageContext(rect.size);
    
    //绘图
    [self drawInRect:rect];
    
    
    //取图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (CGSize)scaleOriginalImageWidth:(CGFloat )imageWidth height:(CGFloat)imageHeight{
    CGSize imageSize = self.size;
    
    CGFloat width;
    
    if (imageSize.width > imageWidth) {
        
        width = imageWidth;
    }else {
        width = imageSize.width;
        
    }
    
    CGFloat height = imageSize.height * width / imageSize.width;
    
    if (height >= imageHeight) {
        height = imageHeight;
     
        width = height * imageSize.width / imageSize.height;
    }
    
    return CGSizeMake(width, height);
}

//保存图像至沙盒
- (void)saveToBoxWithName:(NSString *)imageName {
    
    NSData * imageData = UIImagePNGRepresentation(self);
    NSString * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString * fullPathToFile = [paths stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:fullPathToFile atomically:NO];
    
    NSLog(@"fullPathToFile:%@", fullPathToFile);

}

- (void)jq_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *img))completion{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //测试耗时, 约为0.18秒, 耗时严重, 需要异步绘制
        NSTimeInterval start = CACurrentMediaTime();
        
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        
        //绘制裁切
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        //增加填充颜色, 因为如果设置为透明色, 则影响性能, 所以要指定填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        [path addClip];
        
        [self drawInRect:rect];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        NSLog(@"%f", CACurrentMediaTime() - start);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(img);
            }
        });
    });
}

+ (UIImage *)jq_imageWithColor:(UIColor *)color size:(CGSize)size{

    if (!color || size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
