//
//  WeekSelectView.m
//  Product
//
//  Created by maoge on 2018/1/22.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "WeekSelectView.h"
#import "UIButton+Expand.h"
#import "UIImage+Extension.h"

@interface WeekSelectView()

/// 全部按钮
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
/// 双休日按钮
@property (weak, nonatomic) IBOutlet UIButton *weekendSelectButton;
/// 工作日按钮
@property (weak, nonatomic) IBOutlet UIButton *workdaySelectButton;

@property (nonatomic, weak) UIButton *currentButton;

@end

@implementation WeekSelectView

+ (instancetype)weekSelectView {
    WeekSelectView *view = [[UINib nibWithNibName:@"WeekSelectView" bundle:nil] instantiateWithOwner:nil options:nil].lastObject;
    
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH -10, 200);
    view.backgroundColor = white_color;
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setButtonBackImage];
    
    [self addButtons];
    
}

#pragma mark  - btnClick
// 上面三个按钮点击实现
- (IBAction)topButtonClick:(UIButton *)sender {
    self.currentButton.selected = NO;
    sender.selected = YES;
    self.currentButton = sender;
    
    switch (sender.tag) {
        case 100: // 全部按钮
        {
            for (UIButton *btn in _buttonArray) {
                btn.selected = YES;
            }
        }
            break;
        case 200: // 仅休息日
        {
            for (int i = 0; i < _buttonArray.count; i++) {
                UIButton *btn = _buttonArray[i];
                if (i >= 5) {
                    btn.selected = YES;
                }else {
                    btn.selected = NO;
                }
            }
        }
            break;
        case 300: // 仅工作日
        {
            for (int i = 0; i < _buttonArray.count; i++) {
                UIButton *btn = _buttonArray[i];
                if (i < 5) {
                    btn.selected = YES;
                }else {
                    btn.selected = NO;
                }
            }
        }
            break;
        default:
            break;
    }
}
// 下部七个按钮点击事件
- (void)btnClick:(UIButton *)button {
    button.selected = !button.selected;
    
    _allSelectButton.selected = NO;
    _weekendSelectButton.selected = NO;
    _workdaySelectButton.selected = NO;
    
}

// 中心按钮点击事件
- (void)weekViewWithCenterBtnClick {
    
    if ([self isSelectWeek]) {
        [self makeToast:@"请至少选择一天"];
        return;
    }
    
    NSMutableArray *tempArrM = [NSMutableArray array];
    for (int i = 0; i < _buttonArray.count; i++) {
        UIButton *btn = _buttonArray[i];
        
        if (btn.selected == YES) {
            [tempArrM addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
        }
        
    }
    // 返回星期字符串
    NSString *returnStr = [PopupTool kb_weekdaySortWithDayArray:tempArrM.copy];
    
    // 回调数据
    if (self.weekSelectBlock) {
        self.weekSelectBlock(tempArrM.copy, returnStr);
    }
    
    
}

// 判断如果用户一个都没选则返回YES并弹出提示框
- (BOOL)isSelectWeek {
    for (UIButton *btn in _buttonArray) {
        if (btn.selected == YES) {
            return NO;
        }
    }
    return YES;
}

#pragma mark  - addButton

- (void)setButtonBackImage {
    
    UIImage *normalImage = [UIImage jq_imageWithColor:[UIColor colorWithValue:@"ffffff"] size:_weekendSelectButton.size];
    
    UIImage *selectImage = [UIImage jq_imageWithColor:[UIColor colorWithValue:@"4994EF"] size:_weekendSelectButton.size];
    
    [_allSelectButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_allSelectButton setBackgroundImage:selectImage forState:UIControlStateSelected];
    
    [_weekendSelectButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_weekendSelectButton setBackgroundImage:selectImage forState:UIControlStateSelected];
    
    [_workdaySelectButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_workdaySelectButton setBackgroundImage:selectImage forState:UIControlStateSelected];
}

- (void)addButtons {
    
    CGFloat btnWidth = SCREEN_WIDTH * 0.5 - 5;
    CGFloat btnHeight = 20;
    CGFloat marginY = 10;
    
    NSArray *titleArray = @[@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    
    // 布局
    for (NSInteger i = 0; i < titleArray.count; i++) {
        
        //行列索引
        NSInteger row = i / 2;
        NSInteger col = i % 2;
        
        //计算偏移量
        CGFloat xOffset = btnWidth * col;
        CGFloat yOffset = (btnHeight + marginY) * row + marginY + 50;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithValue:@"333333"] forState:UIControlStateNormal];
       
        [button setImage:[UIImage imageNamed:@"date_check_white"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"date_check_blue"] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setLayout:TitleLeftImageRightStyle spacing:SCREEN_WIDTH * 2/3];
        
        button.frame = CGRectMake(xOffset, yOffset, btnWidth, btnHeight);
        button.tag = i + 1;
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
}



- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


@end
