//
//  UIButton+Expand.m
//  OneStore
//
//  Created by airspuer on 14-5-13.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "UIButton+Expand.h"

@implementation UIButton(Expand)

- (void)setLayout:(UIButtonLayoutStyle )aLayoutStyle
		  spacing:(CGFloat)aSpacing
{

    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    CGFloat totalHeight = (imageSize.height + titleSize.height + aSpacing);
	UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
	UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
	if (aLayoutStyle == ImageLeftTitleRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, -(aSpacing / 2.0f), 0, 0 );
		titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - (aSpacing / 2.0f));
	}
	else if (aLayoutStyle == TitleLeftImageRightStyle) {
		imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + aSpacing / 2.0f));
		titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2 + aSpacing / 2.0f), 0, 0);
	}else if (aLayoutStyle == ImageTopTitleBottomStyle){
		imageEdgeInsets = UIEdgeInsetsMake( -(totalHeight - imageSize.height),
										   0.0,
										   0.0,
										   - titleSize.width);
		titleEdgeInsets  = UIEdgeInsetsMake(0.0,
											-imageSize.width,
											- (totalHeight - titleSize.height),
											0.0);
	}else if (aLayoutStyle == TitleTopImageBottomStyle){
		imageEdgeInsets = UIEdgeInsetsMake(0.0,
										   0.0,
										   -(totalHeight - imageSize.height),
										   - titleSize.width);

		titleEdgeInsets = UIEdgeInsetsMake(-(totalHeight - titleSize.height),
										   0.0,
										   -imageSize.width,
										   0.0);
	}
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.imageEdgeInsets, imageEdgeInsets)
        || !UIEdgeInsetsEqualToEdgeInsets(self.titleEdgeInsets, titleEdgeInsets)) {
        self.imageEdgeInsets = imageEdgeInsets;
        self.titleEdgeInsets = titleEdgeInsets;
        [self layoutIfNeeded];
    }
	
}

- (void)setALayoutStyle:(NSInteger)aLayoutStyle{
    
    objc_setAssociatedObject(self, @selector(aLayoutStyle), @(aLayoutStyle), OBJC_ASSOCIATION_ASSIGN);
    
    [self setLayout:aLayoutStyle spacing:[self aSpacing]];
    
}

- (NSInteger)aLayoutStyle {
    return [objc_getAssociatedObject(self, @selector(aLayoutStyle)) integerValue];
}


- (void)setASpacing:(CGFloat)aSpacing{
    
    objc_setAssociatedObject(self, @selector(aSpacing), @(aSpacing), OBJC_ASSOCIATION_ASSIGN);
    
    [self setLayout:[self aLayoutStyle] spacing:aSpacing];
    
}


- (CGFloat)aSpacing{
    
    return [objc_getAssociatedObject(self, @selector(aSpacing)) floatValue];

    
}



@end
