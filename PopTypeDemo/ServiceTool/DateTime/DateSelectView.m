//
//  DateSelectView.m
//  Product
//
//  Created by maoge on 2018/1/25.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "DateSelectView.h"
#import "NSDate+Category.h"
#import "NSString+DateFormat.h"

@interface DateSelectView()

/// 时间选择器
@property (weak, nonatomic) IBOutlet UIDatePicker *dateTimePicker;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation DateSelectView

+ (instancetype)dateView{
    DateSelectView *view = [[UINib nibWithNibName:@"DateSelectView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH - 10, 180);
    view.backgroundColor = white_color;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    return view;
}


- (void)dateViewWithCenterBtnClick{
    
    NSString *returnTitle = [self.formatter stringFromDate:_dateTimePicker.date];
    NSString *dateStr = [NSDate xh_formatWithDate_yyyy_MM_dd_HH_mm_ss_date:_dateTimePicker.date];
    
    if (self.dateSelectBlock) {
        self.dateSelectBlock(returnTitle, dateStr);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
        
    [self cleanPickerLine];
}

- (void)cleanPickerLine {
    for (UIView *subView1 in self.dateTimePicker.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    subView2.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyyMMdd";
    }
    return _formatter;
}
@end
