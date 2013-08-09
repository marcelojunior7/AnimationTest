//
//  SideScrollerViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 01/08/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface SideScrollerViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic) bool shouldRotateDeviceImage;
@property (nonatomic) bool isRotatingDeviceImage;
@property (nonatomic) bool isTapped;

@property (strong, nonatomic) AVAudioPlayer *playerJump;

@property (strong, nonatomic) NSTimer *sidescrollTimer;

@property (nonatomic) int viewWidth;
@property (nonatomic) int viewHeight;

@property (nonatomic) int currentX;

@property (strong, nonatomic) UIView *ground;

@property (strong, nonatomic) UIView *viewAlerta;
@property (strong, nonatomic) UIView *viewAnimation;

@end
