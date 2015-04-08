//
//  RadioButton.m
//  RadioButton
//
//  Created by MAC on 15/4/8.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import "RadioButton.h"

static CGFloat defaultButtonSideLength = 30.0;
static CGFloat defaultRightMarginWidth = 5.0;
static CGFloat defaultIndicatorRadius = 5.0;
static CGFloat defaultCircleRadius = 11;
static CGFloat defaultStrokeWidh = 3.0;

@implementation RadioButton

#pragma mark - UIView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"drawRect函数被执行");
    [self initilizeButton];
}

#pragma mark - Helpers
- (void)initilizeButton {
    NSLog(@"initilizeButton函数被执行");
    if (!self.ButtonIcon) {
        self.ButtonIcon = [self drawIconWithSelection:NO];
    }
    if (!self.ButtonIconSelected) {
        self.ButtonIconSelected = [self drawIconWithSelection:YES];
    }
    if (![self imageForState:UIControlStateNormal] || ![self imageForState:UIControlStateSelected]) {
        [self setImage:self.ButtonIcon forState:UIControlStateNormal];
        [self setImage:self.ButtonIconSelected forState:UIControlStateSelected];
    }
    CGFloat rightMarginWidth = self.rightMarginWidth ? self.rightMarginWidth : defaultRightMarginWidth;
    if (self.iconOnRight) {
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - (self.ButtonIcon.size.width + rightMarginWidth), 0, 0);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.ButtonIcon.size.width, 0, rightMarginWidth + self.ButtonIcon.size.width);
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, rightMarginWidth, 0, 0);
    }
    [self chainButtons];
    if(![[self allTargets] containsObject:self]) {
        [super addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    }
}

- (UIImage *)drawIconWithSelection:(BOOL)selected {
    NSLog(@"drawIconWithSelection函数被执行");
    UIColor *circleColor = self.circleColor ? self.circleColor : self.titleLabel.textColor;
    UIColor *indicatorColor = self.indicatorColor ? self.indicatorColor : self.titleLabel.textColor;
    CGFloat buttonSideLength = self.buttonSideLength ? self.buttonSideLength : defaultButtonSideLength;
    CGFloat indicatorRadius = self.indicatorRadius ? self.indicatorRadius : defaultIndicatorRadius;
    CGFloat circleRadius = self.circleRadius ? self.circleRadius : defaultCircleRadius;
    CGFloat strokeWidth = self.circleStrokeWidth ? self.circleStrokeWidth : defaultStrokeWidh;
    
    CGRect rect = CGRectMake(0.0, 0.0, buttonSideLength, buttonSideLength);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    if (selected) {
        //indicator绘制
        UIBezierPath* indicatorPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(buttonSideLength/2 - indicatorRadius, buttonSideLength/2 - indicatorRadius, indicatorRadius*2, indicatorRadius*2)];
        [indicatorColor setFill];
        [indicatorPath fill];
        CGContextAddPath(context, indicatorPath.CGPath);
    }
    
    //circle绘制
    UIBezierPath* circlePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(buttonSideLength/2 - circleRadius, buttonSideLength/2 - circleRadius, circleRadius*2, circleRadius*2)];
    [circleColor setStroke];
    circlePath.lineWidth = strokeWidth;
    [circlePath stroke];
    CGContextAddPath(context, circlePath.CGPath);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsPopContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)chainButtons {
    NSLog(@"chainButtons函数被执行");
    if ([self.otherButtons count] > 0) {
        for (RadioButton *radioButton in self.otherButtons) {
            NSMutableArray *otherButtons = [[NSMutableArray alloc] initWithArray:self.otherButtons];
            [otherButtons addObject:self];
            [otherButtons removeObject:radioButton];
            [radioButton setOtherButtons:[otherButtons copy]];
        }
    }
}
#pragma mark - Button被点击
//当RadioButton被点击时执行
- (void)touchDown{
    [self setSelected:YES];
}
//当Button被点击时根据BOOL变量selected来设置整个button池的当前状态
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self deselectOtherButtons];
    }
}
//将button池的其他button设置为deselect (所有otherButton清除选中)
- (void)deselectOtherButtons {
    if ([self.otherButtons count] > 0) {
        for (UIButton *button in self.otherButtons) {
            [button setSelected:NO];
        }
    }
}

#pragma mark - 对象方法
//提供对象方法可以返回当前被选中的RadioButton
- (RadioButton *)selectedButton {
    if (self.selected) {
        return self;
    } else {
        for (RadioButton *radioButton in self.otherButtons) {
            if (radioButton.selected) {
                return radioButton;
            }
        }
        return nil;
    }
}

@end
