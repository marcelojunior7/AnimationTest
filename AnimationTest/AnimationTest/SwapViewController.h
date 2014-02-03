//
//  SwapViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 27/01/14.
//  Copyright (c) 2014 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SwapViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewSwap;
@property (strong, nonatomic) IBOutlet UIView *viewItem;

@property (nonatomic) bool isFlipped;

- (IBAction)btnSwap:(id)sender;

@end
