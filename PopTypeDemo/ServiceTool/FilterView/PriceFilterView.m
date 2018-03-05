//
//  PriceFilterView.m
//  Product
//
//  Created by maoge on 2018/2/24.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "PriceFilterView.h"
#import "PriceSlider.h"
#import "NSAttributedString+Extension.h"

@interface PriceFilterView()<PriceSliderDelegate>
/// 价格滑动选择器
@property (nonatomic, strong) PriceSlider   *priceSlider;
/// 价格展示Label
@property(nonatomic, strong) UILabel        *sliderValueLabel;
/// 价格范围:
@property (nonatomic, strong) UILabel       *priceRange;

@end

@implementation PriceFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    [self addSubview:self.sliderValueLabel];
    [self addSubview:self.priceRange];
    [self addSubview:self.priceSlider];
}


#pragma mark - PriceSliderDelegate
- (void)customSliderValueChanged:(PriceSlider *)slider minValue:(NSString *)minValue maxValue:(NSString *)maxValue{
    
    NSString *resultStr = [NSString stringWithFormat:@"¥%@-¥%@", minValue, maxValue];
    self.sliderValueLabel.attributedText = [NSAttributedString priceSliderString:resultStr];
}

#pragma mark  - lazyLoad
- (PriceSlider *)priceSlider {
    if (_priceSlider == nil) {
        NSArray *titleArray = @[@"0",@"100",@"300",@"500",@"600",@"800",@"1000",@"3000"];
        _priceSlider = [PriceSlider sliderWithArray:titleArray defalutMinValue:0 defalutMaxValue:5 minMaxCanSame:NO];
        _priceSlider.frame = CGRectMake(0, CGRectGetMaxY(_sliderValueLabel.frame), SCREEN_WIDTH - 10, 0);
        _priceSlider.delegate = self;
    }
    return _priceSlider;
}

- (UILabel *)sliderValueLabel {
    if (_sliderValueLabel == nil) {
        _sliderValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 10, SCREEN_WIDTH - _priceSlider.width - 30, 44)];
        _sliderValueLabel.textColor = [UIColor whiteColor];
        _sliderValueLabel.backgroundColor = [UIColor whiteColor];
        _sliderValueLabel.font = [UIFont systemFontOfSize:15.0];
        _sliderValueLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sliderValueLabel;
}

- (UILabel *)priceRange {
    if (_priceRange == nil) {
        _priceRange = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 44)];
        _priceRange.textColor = [UIColor blackColor];
        _priceRange.backgroundColor = [UIColor whiteColor];
        _priceRange.font = [UIFont boldSystemFontOfSize:14];
        _priceRange.text = @"价格范围:";
    }
    return _priceRange;
}



@end
