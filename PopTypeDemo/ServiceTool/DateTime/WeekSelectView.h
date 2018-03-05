//
//  WeekSelectView.h
//  Product
//
//  Created by maoge on 2018/1/22.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeekSelectView : UIView

/// 星期选择返回block
@property (nonatomic, copy) void(^weekSelectBlock)(NSArray *array, NSString *returnTitle);
/// 按钮数组
@property (nonatomic, strong) NSMutableArray *buttonArray;

+ (instancetype)weekSelectView;

- (void)weekViewWithCenterBtnClick;

@end
