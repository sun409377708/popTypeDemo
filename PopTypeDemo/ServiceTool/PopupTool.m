//
//  PopupTool.m
//  Product
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "PopupTool.h"


@implementation PopupTool
IMP_SINGLETON

+ (BasePopUpView *)basePopupWithType:(PopUpViewType)type{

    return [[BasePopUpView alloc] initWithType:type];
}

+ (void)popUpWithController:(UIViewController *)controller type:(PopUpViewType)type  success:(void (^)(id info))success{
    
    // 商户类型选择视图
    BasePopUpView *popView = [self basePopupWithType:type];
    
    __weak typeof(self)weakSelf = self;
    
    popView.basePopUpViewBlock = ^(id result) {
        success(result);
        [weakSelf dismissController:controller];
    };
    
    if (popView.numberView) {
        popView.numberView.quitKeyboard = ^{
            [weakSelf dismissController:controller];
        };
    }
    [self popBottomWithController:controller view:popView];
}

+ (void )popBottomWithController:(UIViewController *)controller view:(UIView *)view{

    controller.zh_popupController = [zhPopupController popupControllerWithMaskType:zhPopupMaskTypeBlackTranslucent];
    controller.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    
    [self popWithController:controller view:view];
}

+ (void)popWithController:(UIViewController *)controller view:(UIView *)view {
    
    controller.zh_popupController.maskTouched = ^(zhPopupController * _Nonnull popupController) {
        [popupController dismissWithDuration:0.25 springAnimated:NO];
    };
    
    [controller.zh_popupController presentContentView:view duration:0.75 springAnimated:YES];
}

+ (void)dismissController:(UIViewController *)controller {
    
    [controller.zh_popupController dismissWithDuration:0.25 springAnimated:NO];
}


+ (NSString *)kb_weekdaySortWithDayArray:(NSArray *)array{
    
    NSArray *titleArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSArray *wholeArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    NSString *wholeStr = [wholeArr componentsJoinedByString:@""];
    
    NSArray *unSeleccArr = [wholeArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF in %@)", array]];
    
    NSString *unSelectStr = [unSeleccArr componentsJoinedByString:@""];
    
    NSArray *sortArr = [wholeStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:unSelectStr]];
    
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:sortArr];
    
    [array1 removeObject:@""];
    
    NSMutableArray *goalArr;
    
    for (NSString *subStr in array1) {
        
        NSString *str1;
        
        if (subStr.length > 1) {
            
            str1 = [self reGetArrayWithString:subStr];
            
        } else {
            
            str1 = titleArr[[subStr integerValue]-1];
        }
        
        if (!goalArr) {
            
            goalArr = [NSMutableArray array];
        }
        [goalArr addObject:str1];
    }
    
    NSString *finalStr = [goalArr componentsJoinedByString:@"、"];
    
    return finalStr;
}

// array表示输入的选定的日期

+ (NSString *)reGetArrayWithString:(NSString *)string {
    
    NSArray *titleArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSString *topStr = [string substringToIndex:1];
    
    NSString *bottomStr = [string substringFromIndex:string.length-1];
    
    NSString *goalStr;
    
    if (string.length >= 3) {
        
        goalStr = [NSString stringWithFormat:@"%@至%@",titleArr[[topStr integerValue]-1],titleArr[[bottomStr integerValue]-1]];
    } else {
        
        goalStr = [NSString stringWithFormat:@"%@、%@",titleArr[[topStr integerValue]-1],titleArr[[bottomStr integerValue]-1]];
    }
    return goalStr;
    
}
@end
