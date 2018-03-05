//
//  FilterSortView.m
//  Product
//
//  Created by maoge on 2018/2/24.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "FilterSortView.h"
#import "PriceFilterView.h"

@interface FilterSortView()
// 价格筛选视图
@property (nonatomic, strong) PriceFilterView       *filterView;
@end

@implementation FilterSortView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 10, 160);
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
         [self configUI];
    }
    return self;
}


#pragma mark  - setUI

- (void)configUI {
    
    [self addSubview:self.filterView];
    
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)filterViewWithCenterBtnClick {
    
 
}

#pragma mark  - lazyLoad

- (PriceFilterView *)filterView {
    if (_filterView == nil) {
        _filterView = [[PriceFilterView alloc] init];
    }
    return _filterView;
}

@end
