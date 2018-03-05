//
//  UIView+view.h
//  fenlei
//
//  Created by hu on 15/5/13.
//  Copyright (c) 2015年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (view)
@property (nonatomic,strong) IBInspectable NSString  *backColor;

/// 边线颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
/// 边线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/// 脚半径
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;


@end
