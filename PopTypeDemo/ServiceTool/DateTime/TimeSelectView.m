//
//  TimeSelectView.m
//  Product
//
//  Created by maoge on 2018/1/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "TimeSelectView.h"
#import "NSDate+Extension.h"

@interface TimeSelectView()
/// 开始时间
@property (weak, nonatomic) IBOutlet UIButton       *startTimeButton;
/// 结束时间
@property (weak, nonatomic) IBOutlet UIButton       *endTimeButton;
/// 时间选择器
@property (weak, nonatomic) IBOutlet UIDatePicker   *dateTimePicker;
/// 时间格式
@property (nonatomic, strong) NSDateFormatter       *formatter;

@property (nonatomic, weak) UIButton                *currentButton;

@end

@implementation TimeSelectView


+ (instancetype)timeView{
    TimeSelectView *view = [[UINib nibWithNibName:@"TimeSelectView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH - 10, 220);
    view.backgroundColor = white_color;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    return view;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // 清除datepickerView中间两条线
    [self cleanPickerLine];
    
    // 手动调用按钮点击事件,默认开始时间按钮为选中状态
    [self timeButtonClick:self.startTimeButton];
    
}


#pragma mark  - actionClick

- (IBAction)timeChange:(UIDatePicker *)datePicker {
    
    NSString *dateResult = [self.formatter stringFromDate:datePicker.date];
    
    if (_startTimeButton.selected) {
        [_startTimeButton setTitle:dateResult forState:UIControlStateNormal];
        [_startTimeButton setTitle:dateResult forState:UIControlStateSelected];

    }else if (_endTimeButton.selected){
        [_endTimeButton setTitle:dateResult forState:UIControlStateNormal];
        [_endTimeButton setTitle:dateResult forState:UIControlStateSelected];
    }

}

- (IBAction)timeButtonClick:(UIButton *)sender {
    self.currentButton.selected = NO;
    sender.selected = YES;
    self.currentButton = sender;
    
}

- (void)timeViewWithCenterBtnClick {

    NSString *startTimeStr = _startTimeButton.titleLabel.text;
    NSString *endTimeStr = _endTimeButton.titleLabel.text;
    
    int results = [NSDate compareOneDay:startTimeStr anotherDay:endTimeStr formatter:_formatter];
  
    if (results != -1) {
        [self makeToast:@"结束时间大于开始时间"];
        return;
    }
    
    if (self.timeSelectBlock) {
        self.timeSelectBlock(startTimeStr, endTimeStr);
    }
}

#pragma mark  - lazyLoad

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc]init];
        _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        [_formatter setAMSymbol:@"上午"];
        [_formatter setPMSymbol:@"下午"];
        _formatter.dateFormat=@"aah:mm";
   
    }
    return _formatter;
}

#pragma mark  - cleanLineMethod

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
@end
