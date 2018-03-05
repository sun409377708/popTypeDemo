//
//  KBNumberView.h
//  数字键盘
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBNumberKeyboard.h"

@interface KBNumberView : UIView
/// 键盘类型
@property (nonatomic, assign) KBInputType inputType;
/// 普通值回调
@property (nonatomic, copy) void(^discountTextBlock)(NSString *text);
/// 价格筛选值回调
@property (nonatomic, copy) void(^maxAndMinPrictTextBlock)(NSString *minText, NSString *maxText);
/// 单词价格回调
@property (nonatomic, copy) void(^normalTextBlock)(CGFloat text);
/// 键盘退出回调
@property (nonatomic, copy) void(^quitKeyboard)(void);

@end
