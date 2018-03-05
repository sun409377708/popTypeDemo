//
//  NSDate+Category.h
//  DateExample
//
//  Created by zhuxiaohui on 2017/4/16.
//  Copyright © 2017年 com.it7090. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

@property(nonatomic,assign,readonly)NSInteger year;
@property(nonatomic,assign,readonly)NSInteger month;
@property(nonatomic,assign,readonly)NSInteger day;
@property(nonatomic,assign,readonly)NSInteger hour;
@property(nonatomic,assign,readonly)NSInteger minute;
@property(nonatomic,assign,readonly)NSInteger seconds;
@property (nonatomic,assign,readonly)NSInteger weekday;

+(NSDate *)xh_dateWithDateString:(NSString *)dateString;

+(NSDate *)xh_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string;
+(NSDate *)xh_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string;
+(NSDate *)xh_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string;
+(NSDate *)xh_dateWithFormat_yyyy_MM_dd_string:(NSString *)string;
+(NSDate *)xh_dateWithFormat_yyyy_MM_string:(NSString *)string;

+(NSString *)xh_formatWithDate_yyyy_MM_dd_HH_mm_ss_date:(NSDate *)date;
+(NSString *)xh_formatWithDate_yyyy_MM_dd_HH_mm_date:(NSDate *)date;
+(NSString *)xh_formatWithDate_yyyy_MM_dd_HH_date:(NSDate *)date;
+(NSString *)xh_formatWithDate_yyyy_MM_dd_date:(NSDate *)date;
+(NSString *)xh_formatWithDate_yyyy_MM_date:(NSDate *)date;

@end
