//
//  RadioButton.h
//  RadioButton
//
//  Created by MAC on 15/4/8.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIButton

//其他相关RadioButton的容器
@property (nonatomic) IBOutletCollection(RadioButton) NSArray *otherButtons;

//RadioButton的Image (可选)
@property (nonatomic) UIImage *ButtonIcon;

//当RadioButton被选中时的Image (可选)
@property (nonatomic) UIImage *ButtonIconSelected;

//Height of the radio button
@property (nonatomic) CGFloat buttonSideLength;

//Margin width between button icon and button title
@property (nonatomic) CGFloat rightMarginWidth;

//Color of the circle button icon
@property (nonatomic) UIColor *circleColor;

//Radius of the circle button icon
@property (nonatomic) CGFloat circleRadius;

//Stroke width of circle button icon
@property (nonatomic) CGFloat circleStrokeWidth;

//被选中的indicator颜色
@property (nonatomic) UIColor *indicatorColor;

//指示器半径
@property (nonatomic) CGFloat indicatorRadius;

//icon是否在右边
@property (nonatomic) BOOL iconOnRight;


//返回当前被选中的Button
- (RadioButton *)selectedButton;

@end
