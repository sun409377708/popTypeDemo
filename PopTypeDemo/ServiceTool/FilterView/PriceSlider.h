//
//  PriceSlider.h
//  Product
//
//  Created by maoge on 2018/2/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PriceSlider;
@protocol PriceSliderDelegate <NSObject>

/**
 *  slider值改变的代理方法
 *
 *  @param slider   slider
 *  @param minValue 最小值
 *  @param maxValue 最大值
 */
- (void)customSliderValueChanged:(PriceSlider *)slider minValue:(NSString *)minValue maxValue:(NSString *)maxValue;
@end


@interface PriceSlider : UIView

/**
 *  初始化一个slider
 *
 *  @param titleArray           标题数组
 *  @param defalutMinValueIndex 初始化显示的最小值index
 *  @param defalutMaxValueIndex 初始化显示的最大值index
 *  @param minMaxCanSame        最小值和最大值是否可以一样
 */
+ (instancetype)sliderWithArray:(NSArray *)titleArray defalutMinValue:(NSInteger)defalutMinValue defalutMaxValue:(NSInteger)defalutMaxValue minMaxCanSame:(BOOL)minMaxCanSame;

@property(nonatomic,weak)id<PriceSliderDelegate> delegate;
@end
