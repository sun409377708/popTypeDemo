//
//  KBNumberKeyboard.h
//  数字键盘
//
//  Created by maoge on 2018/1/17.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KBInputType) {
    KBFilterInputType,         // 价格筛选键盘
    KBDiscountInputType,       // 折扣写入键盘
    KBNormalInputType          // 普通价格键盘
    
};

@interface KBNumberKeyboard : UIView

@property (nonatomic, weak) UITextField<UITextInput> *textInput;

@property (nonatomic, assign) KBInputType inputType;

/// 点击对勾完成按钮
@property (nonatomic, copy) void(^textCompleteBlock)(void);

@end
