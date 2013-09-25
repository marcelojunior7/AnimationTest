//
//  FadeViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 25/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FadeViewController : UIViewController

@property (nonatomic) bool isButtonTextWhite;
@property (nonatomic) bool shouldChangeButtonTextColor;

@property (strong, nonatomic) UIButton *button;

@end
