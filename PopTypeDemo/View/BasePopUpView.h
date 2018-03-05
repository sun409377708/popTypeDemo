//
//  BasePopUpView.h
//  Product
//
//  Created by King on 2017/11/28.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeSelectView.h"
#import "WeekSelectView.h"
#import "DateSelectView.h"
#import "KBNumberView.h"
#import "FilterSortView.h"

typedef NS_ENUM(NSInteger, PopUpViewType) {
    // 星期选择
    PopType_WeekSelect,
    // 日期选择
    PopType_DateSelect,
    // 时间选择
    PopType_TimeSelect,
    // 普通数字键盘
    PopType_normalNumberView,
    // 筛选键盘
    PopType_filterNumberView,
    // 折扣键盘
    PopType_discountNumberView,
    // 价格筛选视图
    PopType_filterSortView
};


@interface BasePopUpView : UIView
/// 选择类型
@property (nonatomic, assign) PopUpViewType     popType;
/// 星期视图
@property (nonatomic, strong) WeekSelectView    *weekView;
/// 日期视图
@property (nonatomic, strong) DateSelectView    *dateView;
/// 时间视图
@property (nonatomic, strong) TimeSelectView    *timeView;
/// 数字键盘视图
@property (nonatomic, strong) KBNumberView      *numberView;
/// 筛选排序视图
@property (nonatomic, strong) FilterSortView    *filterSortView;


/// 赋值回调
@property (nonatomic, copy) void(^basePopUpViewBlock)(id result);

- (instancetype)initWithType:(PopUpViewType)type;

- (instancetype)initWithType:(PopUpViewType)type btnTag:(NSInteger)btnTag;

@end
