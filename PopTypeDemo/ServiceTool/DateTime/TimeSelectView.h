//
//  TimeSelectView.h
//  Product
//
//  Created by maoge on 2018/1/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectView : UIView


@property (nonatomic, copy) void(^timeSelectBlock)(NSString *startTime, NSString *endTime);

+ (instancetype)timeView;

/// 中心按钮点击
- (void)timeViewWithCenterBtnClick;

@end
