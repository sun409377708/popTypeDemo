//
//  PopupTool.h
//  Product
//
//  Created by maoge on 2018/1/18.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePopUpView.h"

#define _PopupTool ([PopupTool sharedInstance])

@interface PopupTool : NSObject
DEF_SINGLETON(PopupTool)

/**
 储存数据的字典
 */
@property (nonatomic, strong) NSMutableDictionary *dictM;

/**
 *  底部弹出视图
 *  @param type       类型(例如日期选择类型, 星期类型)
 */
+ (BasePopUpView *)basePopupWithType:(PopUpViewType)type;

/**
 *  返回星期字符串格式
 *  @param array      输入的数组 (例如 @[@"1", @"2", @"3"])
 */
+ (NSString *)kb_weekdaySortWithDayArray:(NSArray *)array;

/**
 pop底部弹出视图
 */
+ (void)popUpWithController:(UIViewController *)controller type:(PopUpViewType)type  success:(void (^)(id info))success;


@end
