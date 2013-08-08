//
//  SideScrollerViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 01/08/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SideScrollerViewController : UIViewController

@property (nonatomic) bool shouldRotateDeviceImage;
@property (nonatomic) bool isRotatingDeviceImage;

@property (strong, nonatomic) UIView *viewAlerta;
@property (strong, nonatomic) UIView *viewAnimation;

@end
