//
//  KBNumberView.m
//  数字键盘
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "KBNumberView.h"
#import "KBNumberHeadView.h"

@interface KBNumberView()
@property (nonatomic, strong) KBNumberKeyboard *numberKeyboard;

@property (nonatomic, strong) KBNumberHeadView *headView;

/// 折扣TextField
@property (nonatomic, strong) UITextField *discountText;


@end

@implementation KBNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH - 10, 216 + 45);
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;

        [self addNotification];
    }
    return self;
}

- (void)setInputType:(KBInputType)inputType {
    _inputType = inputType;
    
    switch (inputType) {
            // 折扣键盘
        case KBDiscountInputType:
            [self configDiscountUI];
            break;
            // 筛选键盘
        case KBFilterInputType:
            [self configFilterUI];
            break;
            // 普通键盘
        case KBNormalInputType:
            [self configDiscountUI];
            self.discountText.placeholder = @"请输入价格";
        default:
            break;
    }
    // 为键盘赋值类型
    _numberKeyboard.inputType = inputType;
}

- (void)configDiscountUI {
    
    [self addSubview:self.discountText];
    [self addSubview:self.numberKeyboard];
    
    [_discountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(35);
    }];
    
    [_numberKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_discountText.mas_bottom).offset(5);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(216);
    }];
    
    _numberKeyboard.textInput = _discountText;
}

- (void)configFilterUI {
    
    [self addSubview:self.headView];
    [self addSubview:self.numberKeyboard];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
    [_numberKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(216);
    }];
    
    _numberKeyboard.textInput = _headView.minPriceText;
    
    __weak typeof(self)weakSelf = self;
    _headView.textDidBeginBlock = ^(UITextField *textField) {
        weakSelf.numberKeyboard.textInput = textField;
    } ;

}


#pragma mark  - Notification

- (void)completeNotification:(NSNotification *)noty {
    
    switch ([noty.object intValue]) {
        case KBDiscountInputType:
            // 折扣键盘
            [self dealWithDiscountKeyboard];
            break;
        case KBFilterInputType:
            // 价格筛选键盘
            [self dealWithFilterKeyboard];
            break;
            // 普通键盘
        case KBNormalInputType:
            [self dealWithNormalKeyboard];
            break;
        default:
            break;
    }
}

- (void)dealWithNormalKeyboard {
    CGFloat normalValue = _discountText.text.floatValue ?:0;
    
    if (self.normalTextBlock) {
        self.normalTextBlock(normalValue);
    }
}

- (void)dealWithDiscountKeyboard {
    NSString *discountValue = _discountText.text ?:@"0";
    if (discountValue.floatValue > 100) {
        [self makeToast:@"折扣值不能大于100"];
        return;
    }
    
    if (self.discountTextBlock) {
        self.discountTextBlock(discountValue);
    }
}

- (void)dealWithFilterKeyboard {
    CGFloat minValue = _headView.minPriceText.text.floatValue ?:0;
    CGFloat maxValue = _headView.maxPriceText.text.floatValue ?:0;
    // 如果最大价格小于最小价格
    if (maxValue < minValue) {
        [self makeToast:@"最高价格小于最低价格"];
        return;
    }
    
    NSString *minValueStr = [NSString stringWithFormat:@"%.2f", minValue];
    NSString *maxValueStr = [NSString stringWithFormat:@"%.2f", maxValue];

    if (self.maxAndMinPrictTextBlock) {
        self.maxAndMinPrictTextBlock(minValueStr, maxValueStr);
    }
}

- (void)quitTextNotification:(NSNotification *)noty {
    // 退出键盘
    if (self.quitKeyboard) {
        self.quitKeyboard();
    }
}

- (void)addNotification {
    // 处理完成键盘响应通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeNotification:) name:@"sendTextCompleteNotification" object:nil];
    
    // 处理退出键盘响应通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitTextNotification:) name:@"quitTextNotification" object:nil];
}

#pragma mark  - lazyLoad

- (KBNumberKeyboard *)numberKeyboard {
    if (_numberKeyboard == nil) {
        _numberKeyboard = [[UINib nibWithNibName:@"KBNumberKeyboard" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    }
    return _numberKeyboard;
}

- (KBNumberHeadView *)headView {
    if (_headView == nil) {
        _headView = [[UINib nibWithNibName:@"KBNumberHeadView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    }
    return _headView;
}

- (UITextField *)discountText {
    if (_discountText == nil) {
        _discountText = [[UITextField alloc] init];
        _discountText.placeholder = @"请输入折扣";
        _discountText.font = [UIFont systemFontOfSize:14];
        _discountText.inputView = [UIView new];
    }
    return _discountText;
}

@end
