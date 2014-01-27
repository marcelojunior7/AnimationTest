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


#pragma mark - Initialization

- (void)createInitSubviews
{
    // VIEW ===========================================================================
    
    int height = (self.view.frame.size.height * 0.5) - 40;
    int width = (self.view.frame.size.width / 2) - 100;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width, height, 200, 80)];
    
    [view setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1]];
    [self makeViewRound:view withRadius:4.9];
    
    [[self view] addSubview:view];
    
    [view setAlpha:0];
    
    // BUTTON ==========================================================================
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    
    _button = button;
    
    [button setTitle:@"Tap here to start" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(beginBallAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    _isButtonTextWhite = YES;
    _shouldChangeButtonTextColor = YES;
    
//    [self changeButtonTextColorWithinSeconds:@"10.5"];
    
    [view addSubview:button];
    
    [self showInitView];
}


#pragma mark - Animations

- (void)showInitView
{
    [UIView animateWithDuration:0.5 animations:^
     {
         [[[[self view] subviews] objectAtIndex:0] setAlpha:1];
     }
    completion:nil];
}

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
     }
    ];
}

- (void)beginBallAnimation
{
    [UIView animateWithDuration:0.9 animations:^
     {
         [[[[self view] subviews] objectAtIndex:0] setAlpha:0];
     }
    completion:^(BOOL finished)
     {
         [[[[self view] subviews] objectAtIndex:0] removeFromSuperview];
         [self createRoundView];
     }
    ];
}

- (void)createRoundView
{
    // VIEW ======================================================
    
    int height = (self.view.frame.size.height * 0.5) - 40;
    int width = (self.view.frame.size.width / 2) - 40;
    
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(width, height, 80, 80)];
    
    
    // SHADOW ====================================================
    
    [roundView setClipsToBounds:NO];
    [[roundView layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[roundView layer] setShadowOffset:CGSizeMake(0,6)];
    [[roundView layer] setShadowRadius:0.8];
    [[roundView layer] setShadowOpacity:0.3];
    
    
    // BORDER & COLOR ============================================
    
    [[roundView layer] setBorderColor:[UIColor darkGrayColor].CGColor];
    [[roundView layer] setBorderWidth:3.0f];
    
    [roundView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self makeViewRound:roundView withRadius:40];
    
    [roundView setAlpha:0];
    
    
    // ACTIONS ==================================================
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleDoubleTap:)];
    [doubleTap setDelaysTouchesBegan: YES];
    [doubleTap setNumberOfTapsRequired: 2];
    [roundView addGestureRecognizer: doubleTap];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleSingleTap:)];
    [singleTap setDelaysTouchesBegan: YES];
    [singleTap setNumberOfTapsRequired: 1];
    [roundView addGestureRecognizer: singleTap];
    
    // FINAL SETS ===============================================
    
    _roundView = roundView;
    
    [[self view] addSubview:roundView];
    
    [self showRoundView];
}

- (void)showRoundView
{
    [UIView animateWithDuration:0.5 animations:^
     {
         [_roundView setAlpha:1];
     }
    completion:nil];
}


#pragma mark - Round

- (UIView *)makeViewRound:(UIView *)view withRadius:(int)radius
{
    CALayer *round = [view layer];
    
    [round setMasksToBounds:YES];
    [round setCornerRadius:radius];
    
    return view;
}


#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchGeral = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_roundView.frame, touchGeral))
    {
        _isDragging = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isDragging = NO;
    
    CGRect frame = _roundView.frame;
    
    if ((frame.origin.x + frame.size.width / 2) > (self.view.frame.size.width / 2))
    {
        frame.origin.x = (self.view.frame.size.width * 0.9) - (frame.size.width / 2);
    }
    else
    {
        frame.origin.x = (self.view.frame.size.width * 0.1) - (frame.size.width / 2);
    }
    
    [UIView animateWithDuration:0.25 animations:^
     {
         _roundView.frame = frame;
     }
    completion:nil];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGRect frame = _roundView.frame;
    
    if (_isDragging)
    {
        frame.origin.x = touchLocation.x - (frame.size.width / 2);
        frame.origin.y = touchLocation.y - (frame.size.height / 2);

        _roundView.frame = frame;
    }
    
    if ((frame.origin.x + frame.size.width / 2) > (self.view.frame.size.width / 2))
    {
        // SHOW RIGHT GRADIENT
    }
    else
    {
        // SHOW LEFT GRADIENT
    }
}


#pragma mark - handlers

- (void)handleDoubleTap:(UIGestureRecognizer*)sender
{
    [UIView animateWithDuration:0.35 animations:^
     {
         [_roundView setAlpha:0];
     }
    completion:^(BOOL finished)
     {
         [_roundView removeFromSuperview];
         [self createInitSubviews];
     }
    ];
}

- (void)handleSingleTap:(UIGestureRecognizer*)sender
{
    CGRect frame = _roundView.frame;
    frame.origin.x = (self.view.frame.size.width * 0.5) - (frame.size.width / 2);
    frame.origin.y = (self.view.frame.size.height * 0.5) - (frame.size.height / 2);
    
    [UIView animateWithDuration:0.25 animations:^
     {
         _roundView.frame = frame;
     }
    completion:nil];
}

@end
