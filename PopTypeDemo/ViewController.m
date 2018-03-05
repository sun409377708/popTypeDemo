//
//  ViewController.m
//  PopTypeDemo
//
//  Created by maoge on 2018/3/2.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+AssociatedObject.h"

static void *zh_CellButtonKey = &zh_CellButtonKey;


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *styles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.delaysContentTouches = NO;
        _tableView.rowHeight = 90;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(25, 0, 35, 0);
    }
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (!_styles) {
        _styles = @[@"WeekSelect", @"DateSelect", @"filterSortView", @"TimeSelect", @"normalNumberView", @"filterNumberView", @"discountNumberView"];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _styles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.backgroundColor = [UIColor colorWithValue:@"569EED"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"GillSans-SemiBoldItalic" size:22];
        button.layer.cornerRadius = 5;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
//        [button zh_makeConstraints:^(SnailConstraintMaker *make) {
//            [make.width zh_equalTo:220];
//            [make.height zh_equalTo:45];
//            [make.center equalTo:cell.contentView];
//        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(220);
            make.height.mas_equalTo(45);
            make.center.equalTo(cell.contentView);
        }];
        [cell sl_setAssociatedValue:button withKey:zh_CellButtonKey];
    }
    UIButton *button = (UIButton *)[cell sl_getAssociatedValueForKey:zh_CellButtonKey];
    [button setTitle:_styles[indexPath.row] forState:UIControlStateNormal];
    button.tag = indexPath.row;
    return cell;
}

- (void)buttonClicked:(UIButton *)sender {
    NSString *selName = [NSString stringWithFormat:@"example%lu", sender.tag + 1];
    SEL sel = NSSelectorFromString(selName);
    if ([self respondsToSelector:sel]) {
        self.title = _styles[sender.tag];
        [self performSelector:sel withObject:nil afterDelay:0];
    }
}

- (void)example1 {
    // 弹出星期选择视图
    [PopupTool popUpWithController:self type:PopType_WeekSelect success:^(id info) {
        
    }];
}

- (void)example2 {
    // 弹出日期选择
    [PopupTool popUpWithController:self type:PopType_DateSelect success:^(id info) {
        
    }];
}

- (void)example3 {
    // 弹出排序筛选视图
    [PopupTool popUpWithController:self type:PopType_filterSortView success:^(id info) {
        
    }];
}

- (void)example4 {
    // 弹出时间选择
    [PopupTool popUpWithController:self type:PopType_TimeSelect success:^(id info) {
        
    }];
}

- (void)example5 {
    // 弹出普通数字键盘
    [PopupTool popUpWithController:self type:PopType_normalNumberView success:^(id info) {
        
    }];
}
- (void)example6 {
    // 弹出筛选键盘
    [PopupTool popUpWithController:self type:PopType_filterNumberView success:^(id info) {
        
    }];
}
- (void)example7 {
    // 弹出折扣键盘
    [PopupTool popUpWithController:self type:PopType_discountNumberView success:^(id info) {
        
    }];
}


@end
