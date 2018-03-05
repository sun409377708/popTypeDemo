//
//  DateSelectView.h
//  Product
//
//  Created by maoge on 2018/1/25.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateSelectView : UIView

@property (nonatomic, copy) void(^dateSelectBlock)(NSString *returnTitle, NSString *dateStr);

+ (instancetype)dateView;

- (void)dateViewWithCenterBtnClick;

@end
