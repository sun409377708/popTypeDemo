//
//  NSDate+Extension.m
//  Product
//
//  Created by maoge on 2018/1/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+(int)compareOneDay:(NSString *)oneDay anotherDay:(NSString *)anotherDay formatter:(NSDateFormatter *)formatter {
    
    NSDate *dateA = [formatter dateFromString:oneDay];
    
    NSDate *dateB = [formatter dateFromString:anotherDay];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    //NSLog(@"两者时间是同一个时间");
    return 0;
    
}

@end
