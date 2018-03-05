//
//  NSString+DateFormat.m
//  XHDateExample
//
//  Created by zhuxiaohui on 2017/4/16.
//  Copyright © 2017年 com.it7090. All rights reserved.
//

#import "NSString+DateFormat.h"
#import "NSDate+Category.h"

@implementation NSString (DateFormat)

-(NSString *)xh_formatNianYueRi
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月%02ld日",date.year,date.month,date.day];
}
-(NSString *)xh_formatNianYue
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月",date.year,date.month];
}
-(NSString *)xh_formatYueRi
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld月%02ld月",date.month,date.day];
}
-(NSString *)xh_formatNian
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年",date.year];
}
-(NSString *)xh_formatShiFenMiao
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分%02ld秒",date.hour,date.minute,date.seconds];
}
-(NSString *)xh_formatShiFen
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分",date.hour,date.minute];
}
-(NSString *)xh_formatFenMiao
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld分%02ld秒",date.minute,date.seconds];
}
-(NSString *)xh_format_yyyy_MM_dd
{
   NSDate *date = [NSDate xh_dateWithDateString:self];
   return [NSString stringWithFormat:@"%ld-%02ld-%02ld",date.year,date.month,date.day];
}
-(NSString *)xh_format_yyyy_MM
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld-%02ld",date.year,date.month];
}
-(NSString *)xh_format_MM_dd
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld-%02ld",date.month,date.day];
}
-(NSString *)xh_format_yyyy
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld",date.year];
}
-(NSString *)xh_format_HH_mm_ss
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",date.hour,date.minute,date.seconds];
}
-(NSString *)xh_format_HH_mm
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.hour,date.minute];
}
-(NSString *)xh_format_mm_ss
{
    NSDate *date = [NSDate xh_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.minute,date.seconds];
}

-(NSString *)xh_formatWeekDay
{
    NSString *weekStr=nil;
    NSDate *date = [NSDate xh_dateWithDateString:self];
    switch (date.weekday) {
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        case 1:
            weekStr = @"星期天";
            break;
        default:
            break;
    }
    return weekStr;
}


/**
 *  判断日期是否是几年
 */
- (BOOL)isThisYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDate *date = [NSDate xh_dateWithDateString:self];
    
    NSDateComponents *dateCmps = [calender components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowCmps = [calender components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *currentDate = [NSDate xh_dateWithDateString:self];
    // 主要是去掉后面的 分钟 秒
    NSDate *now = [NSDate date];
    NSString *dateStr = [fmt stringFromDate:currentDate];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calender components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
     NSDate *currentDate = [NSDate xh_dateWithDateString:self];
    NSDate *now = [NSDate date];
    NSString *dateStr = [fmt stringFromDate:currentDate];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
