//
//  PriceSlider.m
//  Product
//
//  Created by maoge on 2018/2/26.
//  Copyright © 2018年 maoge. All rights reserved.
//

#import "PriceSlider.h"
#import "UIImage+Extension.h"

#define kPADDING  0.5 // 按钮间距
#define kMARGIN   0  // 边距
#define kLineDefaultColor [UIColor colorWithValue:@"999999"]
#define kLineSelectColor [UIColor colorWithValue:@"0557ff"]


@interface PriceSlider()

@property(nonatomic,strong)NSArray *titleArray;
/**min按钮默认显示的下标*/
@property(nonatomic,assign)NSInteger defalutMinValueIndex;
/**max按钮默认显示的下标*/
@property(nonatomic,assign)NSInteger defalutMaxValueIndex;
/**最小值和最大值是否可以一样*/
@property(nonatomic,assign)BOOL minMaxCanSame;

@property(nonatomic,weak)UIView *sliderView;
@property(nonatomic,strong)UIButton *minSliderButton;
@property(nonatomic,strong)UIButton *maxSliderButton;
/**标题Label数组*/
@property(nonatomic,strong)NSMutableArray *titleLabelArray;
/**圆点数组*/
@property(nonatomic,strong)NSMutableArray *circleArray;
/**一个刻度的长度*/
@property(nonatomic,assign)CGFloat scale;
/**蓝线视图*/
@property (nonatomic, strong) UIView *lineView;
/**底部灰色视图*/
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation PriceSlider

+ (instancetype)sliderWithArray:(NSArray *)titleArray defalutMinValue:(NSInteger)defalutMinValue defalutMaxValue:(NSInteger)defalutMaxValue minMaxCanSame:(BOOL)minMaxCanSame{
    
    return [[self alloc]initWithTitleArray:titleArray withDefalutMinValueIndex:defalutMinValue withDefalutMaxValueIndex:defalutMaxValue andMinMaxCanSame:minMaxCanSame];
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray withDefalutMinValueIndex:(NSInteger)defalutMinValueIndex withDefalutMaxValueIndex:(NSInteger)defalutMaxValueIndex andMinMaxCanSame:(BOOL)minMaxCanSame {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
        
        _defalutMinValueIndex = defalutMinValueIndex;
        _defalutMaxValueIndex = defalutMaxValueIndex;
        _minMaxCanSame = minMaxCanSame;
        self.titleArray = titleArray;
    }
    return self;
}

- (void)configUI {
    UIView *sliderView = [[UIView alloc]init];
    sliderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:sliderView];
    self.sliderView = sliderView;
    
    [sliderView addSubview:self.bottomView];
    [sliderView addSubview:self.minSliderButton];
    [sliderView addSubview:self.maxSliderButton];
    [sliderView addSubview:self.lineView];
    
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    for (NSString *title in _titleArray) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = kLineDefaultColor;
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        [self addSubview:titleLabel];
        [self.titleLabelArray addObject:titleLabel];
    }
    
    UIImage *normalImage = [UIImage jq_imageWithColor:kLineDefaultColor size:CGSizeMake(6, 6)];
    UIImage *heigLightedImage = [UIImage jq_imageWithColor:kLineSelectColor size:CGSizeMake(6, 6)];
    
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *dotButton = [[UIButton alloc] init];
        dotButton.layer.cornerRadius = 3;
        dotButton.layer.masksToBounds = YES;
        
        [dotButton setImage:normalImage forState:UIControlStateNormal];
        [dotButton setImage:heigLightedImage forState:UIControlStateHighlighted];
    
        [_sliderView insertSubview:dotButton belowSubview:self.minSliderButton];
        
        dotButton.userInteractionEnabled = NO;
        [self.circleArray addObject:dotButton];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger titleLabelCount = self.titleLabelArray.count;
    
    if (titleLabelCount == 0) {
        return;
    }
    
    CGFloat contentW = self.width-2*kMARGIN; // 内容宽度
    CGFloat titleLabelW = (contentW-(titleLabelCount-1)*kPADDING)/titleLabelCount;
    self.scale = titleLabelW;// 每个刻度的宽度
    
    
    CGFloat sliderViewH = 0;
    if (_minSliderButton.currentImage != nil) {
        sliderViewH = _minSliderButton.currentImage.size.height*(titleLabelW/_minSliderButton.currentImage.size.width);
    }
    _sliderView.frame = CGRectMake(kMARGIN, kPADDING, contentW, sliderViewH);
    
    UILabel *lastLabel;
    for (NSInteger index = 0; index < titleLabelCount; index++ ) {
        UILabel *titleLabel = self.titleLabelArray[index];
        titleLabel.left = kMARGIN + index*(titleLabelW+kPADDING);
        titleLabel.top = CGRectGetMaxY(_sliderView.frame);
        titleLabel.width = titleLabelW;
        titleLabel.height = 12;
        if (index == titleLabelCount-1) {
            lastLabel = titleLabel;
        }
        
        UIButton *dotButton = self.circleArray[index];
        dotButton.left = CGRectGetMidX(titleLabel.frame) - 2.0;
        dotButton.top = _sliderView.height * 0.5 - 4.0;
        dotButton.width = 6;
        dotButton.height = 6;
    }
    
    _minSliderButton.left = _defalutMinValueIndex*(titleLabelW+kPADDING);
    _minSliderButton.width = titleLabelW ;
    _minSliderButton.height = sliderViewH ;
    _minSliderButton.top = titleLabelW * 0;
    _minSliderButton.layer.cornerRadius = titleLabelW * 0.5;
    
    _maxSliderButton.frame = _minSliderButton.frame;
    _maxSliderButton.left = _defalutMaxValueIndex*(titleLabelW+kPADDING);
    _maxSliderButton.layer.cornerRadius = titleLabelW * 0.5;
    
    
    self.height = CGRectGetMaxY(_sliderView.frame)+kMARGIN;
    _lineView.top = _sliderView.height * 0.5 - 2.0;
    
    _bottomView.left = kMARGIN + _minSliderButton.width * 0.5;
    _bottomView.top = _lineView.top;
    _bottomView.width = _sliderView.width - (kMARGIN + _minSliderButton.width);
    _bottomView.height = 2.0;
    
    [self valueChanged];
}

- (void)changeLineAndPoint {
    
    _lineView.left = _minSliderButton.left + _minSliderButton.width - (_sliderView.height * 0.2);
    _lineView.width = _maxSliderButton.left - _lineView.left + (_sliderView.height * 0.2);
    
    for (UIButton *circleButton in _circleArray) {
        
        if (CGRectContainsPoint(CGRectMake(_lineView.left, _sliderView.height * 0.5 - 4.0, _lineView.width, _lineView.height), circleButton.frame.origin)) {
            circleButton.highlighted = YES;
        }else {
            circleButton.highlighted = NO;
        }
    }
}

/**minSlider拖动事件*/
- (void)panMinSliderButton:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan translationInView:pan.view];
    
    CGFloat toX = self.minSliderButton.left + panPoint.x;
    [pan setTranslation:CGPointZero inView:pan.view];
    
    CGFloat panMaxX = 0;
    if (_minMaxCanSame) {
        panMaxX = self.maxSliderButton.left; // 可重叠
    }else {
        panMaxX = self.maxSliderButton.left-self.minSliderButton.width-kPADDING; // 不能重叠
    }
    
    int a = (int)ceil(toX/_scale); // 表示滑动了几个刻度的距离
    float b = (toX/_scale) - ((int)floor(toX/_scale));
    if (toX >= 0 && toX <= panMaxX) {
        self.minSliderButton.left = toX;
    }
    
    [self changeLineAndPoint];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (ABS(b) > 0.5) {
            toX = a*(_scale+kPADDING);
        }else {
            toX = (a-1)*(_scale+kPADDING);
        }
        if (toX >= 0 && toX <= panMaxX) {
            self.minSliderButton.left = toX;
        }else {
            if (toX < 0) {
                toX = 0;
            }else if (toX > panMaxX) {
                toX = panMaxX;
            }
            self.minSliderButton.left = toX;
        }
        
        if (self.minSliderButton.left == self.maxSliderButton.left) {
            [self.sliderView sendSubviewToBack:self.maxSliderButton];
        }
        [self valueChanged];
    }
}

/**maxSlider拖动事件*/
- (void)panMaxSliderButton:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan translationInView:pan.view];
    [pan setTranslation:CGPointZero inView:pan.view];
    
    CGFloat toX = self.maxSliderButton.left + panPoint.x;
    CGFloat panMaxX = self.sliderView.width - self.maxSliderButton.width;
    
    CGFloat minX = 0;
    if (_minMaxCanSame) {
        minX = self.minSliderButton.left; // 可重叠
    }else {
        minX = CGRectGetMaxX(self.minSliderButton.frame)+kPADDING; // 不可重叠
    }
    
    int a = (int)ceil(toX/_scale); // 表示滑动了几个刻度的距离
    float b = (toX/_scale) - ((int)floor(toX/_scale));
    if (toX >= minX && toX <= panMaxX) {
        self.maxSliderButton.left = toX;
    }
    
    [self changeLineAndPoint];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (ABS(b) > 0.5) {
            toX = a*(_scale+kPADDING);
        }else {
            toX = (a-1)*(_scale+kPADDING);
        }
        if (toX >= minX && toX <= panMaxX) {
            self.self.maxSliderButton.left = toX ;
        }else {
            if (toX < minX) {
                toX = 0;
            }else if (toX > panMaxX) {
                toX = panMaxX;
            }
            self.self.maxSliderButton.left = toX;
        }
        if (self.maxSliderButton.left == self.minSliderButton.left) {
            [self.sliderView sendSubviewToBack:self.minSliderButton];
        }
        
        [self valueChanged];
    }
}

- (void)valueChanged {
    
    [self changeLineAndPoint];
    
    if ([self.delegate respondsToSelector:@selector(customSliderValueChanged:minValue:maxValue:)]) {
        NSString *minValue = _titleArray[(int)(self.minSliderButton.left/(_scale+kPADDING))];
        NSString *maxValue = _titleArray[(int)(self.maxSliderButton.left/(_scale+kPADDING))];
        [self.delegate customSliderValueChanged:self minValue:minValue maxValue:maxValue];
    }
}

- (NSMutableArray *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = [NSMutableArray array];
    }
    return _titleLabelArray;
}

- (NSMutableArray *)circleArray {
    if (!_circleArray) {
        _circleArray = [NSMutableArray array];
    }
    return _circleArray;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 2)];
        _lineView.backgroundColor  = kLineSelectColor;
    }
    
    return _lineView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kLineDefaultColor;
    }
    return _bottomView;
}

- (UIButton *)minSliderButton {
    if (_minSliderButton == nil) {
        _minSliderButton = [[UIButton alloc]init];
        [_minSliderButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [_minSliderButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateHighlighted];
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMinSliderButton:)];
        [_minSliderButton addGestureRecognizer:recognizer];
    }
    return _minSliderButton;
}

- (UIButton *)maxSliderButton {
    if (_maxSliderButton == nil) {
        _maxSliderButton = [[UIButton alloc]init];
        [_maxSliderButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [_maxSliderButton setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateHighlighted];
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panMaxSliderButton:)];
        [_maxSliderButton addGestureRecognizer:recognizer];
    }
    return _maxSliderButton;
}
@end
