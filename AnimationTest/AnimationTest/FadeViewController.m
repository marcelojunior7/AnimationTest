//
//  FadeViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 25/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import "FadeViewController.h"

@interface FadeViewController ()

@end

@implementation FadeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createInitSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma Initialization

- (void)createInitSubviews
{
    // VIEW ===========================================================================
    
    int height = (self.view.frame.size.height * 0.8) - 40;
    int width = (self.view.frame.size.width / 2) - 100;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width, height, 200, 80)];
    
    [view setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1]];
    [self makeViewRound:view withRadius:4.9];
    
    [[self view] addSubview:view];
    
    
    // BUTTON ==========================================================================
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    _button = button;
    
    [button setTitle:@"Tap here to start" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(beginBallAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    _isButtonTextWhite = YES;
    _shouldChangeButtonTextColor = YES;
    
    [self changeButtonTextColorWithinSeconds:@"10.5"];
    
    [view addSubview:button];
}


#pragma Animations

- (void)changeButtonTextColorWithinSeconds:(NSString *)secs
{
    int segundos = [secs intValue];
    
    [UIView animateWithDuration:segundos animations:^
     {
         UIButton *button = _button;
         UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
         
         if (_isButtonTextWhite)
         {
             color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
         }
         
         _isButtonTextWhite = !_isButtonTextWhite;
         
         [button setTitleColor:color forState:UIControlStateNormal];
     }
    completion:^(BOOL finished)
     {
         if (_shouldChangeButtonTextColor)
         {
             [self performSelector:@selector(changeButtonTextColorWithinSeconds:) withObject:secs afterDelay:1.5];
         }
     }];
}

- (void)beginBallAnimation
{
    [UIView animateWithDuration:1.5 animations:^
     {
         [[[[self view] subviews] objectAtIndex:0] setAlpha:0];
     }
    completion:^(BOOL finished)
     {
         [[[[self view] subviews] objectAtIndex:0] removeFromSuperview];
         
         [self createRoundViews];
     }];
}

- (void)createRoundViews
{
    
}

#pragma Round

- (UIView *)makeViewRound:(UIView *)view withRadius:(int)radius
{
    CALayer *round = [view layer];
    [round setMasksToBounds:YES];
    [round setCornerRadius:radius];
    
    return view;
}

@end
