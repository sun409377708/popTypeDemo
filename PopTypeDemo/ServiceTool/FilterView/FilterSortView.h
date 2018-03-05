//
//  FilterSortView.h
//  Product
//
//  Created by maoge on 2018/2/24.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterSortView : UIView

@property (nonatomic, copy) void(^filterSortViewBlock)(id value);


- (void)filterViewWithCenterBtnClick;
@end
