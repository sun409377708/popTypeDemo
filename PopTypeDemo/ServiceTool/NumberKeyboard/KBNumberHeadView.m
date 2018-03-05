//
//  KBNumberHeadView.m
//  数字键盘
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "KBNumberHeadView.h"

@implementation KBNumberHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 防止系统键盘弹出
    self.minPriceText.inputView = [UIView new];
    self.maxPriceText.inputView = [UIView new];
}

- (IBAction)textDidClick:(UITextField *)sender {
    
    if (self.textDidBeginBlock) {
        self.textDidBeginBlock(sender);
    }
}

@end
