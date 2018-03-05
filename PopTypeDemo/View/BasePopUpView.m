//
//  BasePopUpView.m
//  Product
//
//  Created by King on 2017/11/28.
//  Copyright © 2017年 maoge. All rights reserved.
//

#import "BasePopUpView.h"
#import "UIButton+Expand.h"
#import "NSAttributedString+Extension.h"



@interface BasePopUpView ()
/// 中心按钮
@property (nonatomic, strong) UIButton          *centerBtn;
/// 按钮蓝色视图
@property (nonatomic, strong) UIView            *blueView;

@property (nonatomic, assign) NSInteger         btnTag;
@end

@implementation BasePopUpView

- (instancetype)initWithType:(PopUpViewType)type {
    if (self = [super init]) {
        
        [self configWithType:type];
        
        [self dealWithNormalBlock];
    }
    return self;
}

- (instancetype)initWithType:(PopUpViewType)type btnTag:(NSInteger)btnTag {
    if (self = [super init]) {
        
        _btnTag = btnTag;
        [self configWithType:type];
        
        [self dealWithFilterBlock];
    }
    return self;
}

- (void)dealWithNormalBlock {
    __weak typeof(self)weakSelf = self;
    
    _weekView.weekSelectBlock = ^(NSArray *array, NSString *returnTitle) {
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(returnTitle);
        }
    };
    
    _timeView.timeSelectBlock = ^(NSString *startTime, NSString *endTime) {
        
        NSString *result = [NSString stringWithFormat:@"%@-%@", startTime, endTime];
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(result);
        }
    };
    
    _numberView.normalTextBlock = ^(CGFloat text) {
        
        NSString *result = [NSString stringWithFormat:@"¥%.2f",text];
        NSAttributedString *attStr = [NSAttributedString filterOneCharacter:result];
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(attStr);
        }
    };
    
    _numberView.discountTextBlock = ^(NSString *text) {
        
        NSString *result = [NSString stringWithFormat:@"%@%%",text];
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(result);
        }
    };

    _numberView.maxAndMinPrictTextBlock = ^(NSString *minText, NSString *maxText) {
        
        NSString *result = [NSString stringWithFormat:@"¥%@-¥%@",minText, maxText];
        NSAttributedString *attStr = [NSAttributedString filterTwoCharacter:result];
        
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(attStr);
        }
    };
    
    _dateView.dateSelectBlock = ^(NSString *returnTitle, NSString *dateStr) {
        
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(returnTitle);
        }
    };
}

- (void)dealWithFilterBlock {
    
    __weak typeof(self)weakSelf = self;
    _filterSortView.filterSortViewBlock = ^(id value) {
        
        if (weakSelf.basePopUpViewBlock) {
            weakSelf.basePopUpViewBlock(value);
        }
    };
}

#pragma mark  - configUI

- (void)configWithType:(PopUpViewType)type {
    _popType = type;
    switch (type) {
        case PopType_WeekSelect:
            [self configButtonView:self.weekView];
            
            break;
        case PopType_DateSelect:
            [self configButtonView:self.dateView];
            
            break;
        case PopType_TimeSelect:
            [self configButtonView:self.timeView];
            
            break;
        case PopType_normalNumberView:
            [self configNoButtonView:self.numberView];
            _numberView.inputType = KBNormalInputType;
            
            break;
        case PopType_filterNumberView:
            [self configNoButtonView:self.numberView];
            _numberView.inputType = KBFilterInputType;
            
            break;
        case PopType_discountNumberView:
            [self configNoButtonView:self.numberView];
            _numberView.inputType = KBDiscountInputType;
            
            break;
        case PopType_filterSortView:
            [self configButtonView:self.filterSortView];
            
            break;
        default:
            break;
    }
    
}

// 有底部按钮
- (void)configButtonView:(UIView *)view {
    [self addSubview:view];
    self.width = view.width;
    self.height = view.height + 20;
    
    // 添加中心按钮
    [self addCenterButton];
}

// 无底部按钮
- (void)configNoButtonView:(UIView *)view {
    [self addSubview:view];
    self.bounds = view.bounds;
}

- (void)addCenterButton {
    
    [self addSubview:self.centerBtn];
    [self insertSubview:self.blueView belowSubview:_centerBtn];
    
    [_centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.equalTo(self).offset(0);
    }];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_centerBtn);
        make.size.equalTo(_centerBtn);
    }];
    
    [UIView animateWithDuration:2 delay:0.25 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        
        _blueView.transform = CGAffineTransformMakeScale(1.15, 1.15);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark  - centerButton
// 中心按钮点击事件
- (void)closeCenterBtn:(UIButton *)sender {
    
    switch (_popType) {
        case PopType_WeekSelect:
            [_weekView weekViewWithCenterBtnClick];
            break;
        case PopType_TimeSelect:
            [_timeView timeViewWithCenterBtnClick];
            break;
        case PopType_DateSelect:
            [_dateView dateViewWithCenterBtnClick];
            break;
        case PopType_filterSortView:
            [_filterSortView filterViewWithCenterBtnClick];
        default:
            break;
    }
 
}


#pragma mark  - lazyLoad

-(UIButton *)centerBtn{
    
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc]init];
        [_centerBtn setImage:[UIImage imageNamed:@"confirmation_selection_blue"] forState:UIControlStateNormal];
        [_centerBtn setImage:[UIImage imageNamed:@"confirmation_selection_gray"] forState:UIControlStateDisabled];
        [_centerBtn addTarget:self action:@selector(closeCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (UIView *)blueView {
    if (_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = COLOR(117, 155, 240, 0.5);
        _blueView.layer.cornerRadius = 25;
        _blueView.layer.masksToBounds = YES;
    }
    return _blueView;
}

- (WeekSelectView *)weekView {
    if (_weekView == nil) {
        _weekView = [WeekSelectView weekSelectView];
    }
    return _weekView;
}

- (DateSelectView *)dateView {
    if (_dateView == nil) {
        _dateView = [DateSelectView dateView];
    }
    return _dateView;
}

- (TimeSelectView *)timeView {
    if (_timeView == nil) {
        _timeView = [TimeSelectView timeView];
    }
    return _timeView;
}


- (KBNumberView *)numberView {
    if (_numberView == nil) {
        _numberView = [[KBNumberView alloc] init];
    }
    return _numberView;
}

- (FilterSortView *)filterSortView {
    if (_filterSortView == nil) {
        _filterSortView = [[FilterSortView alloc] init];
    }
    return _filterSortView;
}
@end
