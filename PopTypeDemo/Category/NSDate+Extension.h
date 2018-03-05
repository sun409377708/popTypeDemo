//
//  NSDate+Extension.h
//  Product
//
//  Created by maoge on 2018/1/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
// 比较两个日期大小
+(int)compareOneDay:(NSString *)oneDay anotherDay:(NSString *)anotherDay formatter:(NSDateFormatter *)formatter;
@end
