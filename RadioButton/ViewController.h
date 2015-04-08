//
//  ViewController.h
//  RadioButton
//
//  Created by MAC on 15/4/8.
//  Copyright (c) 2015年 SaiDiCaprio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

#define SCREEN_VIEW_WIDTH self.view.frame.size.width
@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *RadioButtons;
@property (nonatomic) NSArray *bottomRadioButtons;
- (IBAction)firstButtonTapped;
- (IBAction)secondButtonTapped;

@end

