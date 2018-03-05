//
//  KBNumberKeyboard.m
//  数字键盘
//
//  Created by maoge on 2018/1/17.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "KBNumberKeyboard.h"

@implementation KBNumberKeyboard

- (IBAction)keyboardAction:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    switch (tag)
    {
        case 1010:
        {
            // 小数点
            if(self.textInput.text.length > 0 && ![self.textInput.text containsString:@"."])
                [self.textInput insertText:@"."];
        }
            break;
        case 1011:
        {
            // 退出键盘
            [[NSNotificationCenter defaultCenter] postNotificationName:@"quitTextNotification" object:nil];

        }
            break;
        case 1012:
        {
            // 删除
            if(self.textInput.text.length > 0)
                [self.textInput deleteBackward];
        }
            break;
        case 1013:
        {
            // 确认
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sendTextCompleteNotification" object:@(_inputType)];
        }
            break;
        default:
        {
            // 数字
            NSString *text = [NSString stringWithFormat:@"%ld",sender.tag - 1000];
            [self.textInput insertText:text];
            
        }
            break;
    }
}

@end
