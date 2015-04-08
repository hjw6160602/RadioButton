//
//  ViewController.m
//  RadioButton
//
//  Created by MAC on 15/4/8.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopControls];
    [self initBottomControls];
}
#pragma mark - init
-(void)initTopControls{
    //设置Button图标
    for (RadioButton *radioButton in self.RadioButtons) {
        radioButton.ButtonIcon = [UIImage imageNamed:@"RadioButton"];
        radioButton.ButtonIconSelected = [UIImage imageNamed:@"RadioButtonSelected"];
    }
}

- (void)initBottomControls{
    //首个Button
    RadioButton *firstRadioButton = [[RadioButton alloc] initWithFrame:CGRectMake(30, 200, SCREEN_VIEW_WIDTH-60, 30)];
    firstRadioButton.buttonSideLength = 30;
    [firstRadioButton setTitle:@"Red Button" forState:UIControlStateNormal];
    [firstRadioButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstRadioButton.circleColor = [UIColor redColor];
    firstRadioButton.indicatorColor = [UIColor redColor];
    firstRadioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //其他Button
    [self.view addSubview:firstRadioButton];
    NSArray *colorNames = @[@"Orange", @"Green", @"Cyon", @"Blue", @"Purple"];
    NSArray *buttonColors = @[[UIColor orangeColor], [UIColor greenColor], [UIColor cyanColor], [UIColor blueColor], [UIColor purpleColor]];
    //NSArray *colorNames = @[@"Orange", @"Green"];
    //NSArray *buttonColors = @[[UIColor orangeColor], [UIColor greenColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *buttonColor in buttonColors) {
        //自定义Button
        RadioButton *radioButton = [[RadioButton alloc] initWithFrame:CGRectMake(30, 240+40*i,  SCREEN_VIEW_WIDTH-60, 30)];
        radioButton.buttonSideLength = 30;
        [radioButton setTitle:[colorNames[i] stringByAppendingString:@" Button"] forState:UIControlStateNormal];
        [radioButton setTitleColor:buttonColor forState:UIControlStateNormal];
        radioButton.circleColor = buttonColor;
        radioButton.indicatorColor = buttonColor;
        if (i > 1) {
            //把Button的icon放在右边
            radioButton.iconOnRight = YES;
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
            radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        [otherButtons addObject:radioButton];
        [self.view addSubview:radioButton];
        i++;
    }
    firstRadioButton.otherButtons = otherButtons;
    self.bottomRadioButtons = [@[firstRadioButton] arrayByAddingObjectsFromArray:otherButtons];
}

#pragma mark - Actions
- (IBAction)firstButtonTapped {
    [self showSelectedButton:self.RadioButtons];
}

- (IBAction)secondButtonTapped {
    [self showSelectedButton:self.bottomRadioButtons];
}

- (void)showSelectedButton:(NSArray *)radioButtons {
    NSString *buttonName = [(RadioButton *)radioButtons[0] selectedButton].titleLabel.text;
    [[[UIAlertView alloc] initWithTitle:buttonName ? @"Selected Button" : @"No Button Selected"
                                message:buttonName
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil]show];
}


@end
