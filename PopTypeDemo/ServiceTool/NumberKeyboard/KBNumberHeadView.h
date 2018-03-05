//
//  KBNumberHeadView.h
//  数字键盘
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBNumberHeadView : UIView
/// 最低价TextField
@property (weak, nonatomic) IBOutlet UITextField *minPriceText;
/// 最高价TextField
@property (weak, nonatomic) IBOutlet UITextField *maxPriceText;
/// 切换响应者block
@property (nonatomic, copy) void(^textDidBeginBlock)(UITextField *);

@end
