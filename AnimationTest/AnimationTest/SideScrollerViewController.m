//
//  SideScrollerViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 01/08/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import "SideScrollerViewController.h"

@interface SideScrollerViewController ()

@end

@implementation SideScrollerViewController

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
    
    _viewAlerta = [[UIView alloc] init];
    _viewAnimation = [[UIView alloc] init];
    
    _shouldRotateDeviceImage = NO;
    _isRotatingDeviceImage = NO;
    
    UIView *view = [[UIView alloc] init];
        
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(90, 150, 150, 150)];
        [view setBackgroundColor:[UIColor clearColor]];
        
        _viewAlerta = view;
        [[self view] addSubview:view];
        _shouldRotateDeviceImage = YES;
        [self showPortraitAlert];
    }
    else
    {
        [self createAnimationView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma orientation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    _viewAlerta = [[UIView alloc] init];
    _viewAnimation = [[UIView alloc] init];
    
    _shouldRotateDeviceImage = NO;
    
    for (int i = 0; [[[self view] subviews] count] > i; i++)
    {
        [[[[self view] subviews] objectAtIndex:i] removeFromSuperview];
    }
    
    if(toInterfaceOrientation == 0 || toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(90, 150, 150, 150)];
        
        [[self view] addSubview:viewContainer];
        
        _viewAlerta = viewContainer;
        [viewContainer setBackgroundColor:[UIColor clearColor]];
        
        _shouldRotateDeviceImage = YES;
        [self showPortraitAlert];
    }
    else
    {
        [self createAnimationView];
    }
}


#pragma Alerta

- (void)showPortraitAlert
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [view setBackgroundColor:[UIColor darkGrayColor]];
    [view setAlpha:0.3];
    
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:4.9];
    
    UIImageView *deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [[[UIDevice currentDevice].model stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"Simulator" withString:@""]]]];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"Turn landscape to animate!"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:2];
    
    [_viewAlerta setAlpha:0];

    [_viewAlerta addSubview:view];
    [_viewAlerta addSubview:deviceImage];
    [_viewAlerta addSubview:label];
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setFrame:CGRectMake(0, 95, 150, 40)];
    [deviceImage setFrame:CGRectMake(45, 15, 60, 65)];
    
    [UIView animateWithDuration:0.5 animations:^
     {
         [_viewAlerta setAlpha:1];
     }
    completion:nil];
    
    if (!_isRotatingDeviceImage)
    {
        [self performSelector:@selector(rotateDeviceImage) withObject:nil afterDelay:2.5];
    }
}

- (void)rotateDeviceImage
{
    if (_shouldRotateDeviceImage)
    {
        _isRotatingDeviceImage = YES;
        UIView *deviceImage = [[_viewAlerta subviews] objectAtIndex:1];
        
        [UIView animateWithDuration:0.3 animations:^
         {
             [deviceImage setTransform:CGAffineTransformMakeRotation(((90) * M_PI / 180.0))];
         }
        completion:^(BOOL finished)
         {
             [self performSelector:@selector(repeatDeviceImageRotation) withObject:nil afterDelay:2.5];
         }
        ];
    }
    else
    {
        _isRotatingDeviceImage = NO;
    }
}

- (void)repeatDeviceImageRotation
{
    if (_shouldRotateDeviceImage)
    {
        UIView *deviceImage = [[_viewAlerta subviews] objectAtIndex:1];
        
        [UIView animateWithDuration:0.3 animations:^
         {
            [deviceImage setAlpha:0];
         }
        completion:^(BOOL finished)
         {
             [deviceImage setTransform:CGAffineTransformMakeRotation(((0) * M_PI / 180.0))];
             
            [UIView animateWithDuration:0.3 animations:^
             {
                  [deviceImage setAlpha:1];
             }
            completion:^(BOOL finished)
             {
                  [self rotateDeviceImage];
             }
            ];
         }
        ];
    }
    else
    {
        _isRotatingDeviceImage = NO;
    }
}


#pragma Animation

- (void)createAnimationView
{
    UIView *viewAnimation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _viewAnimation = viewAnimation;
    [self.view addSubview:viewAnimation];
    
    /* FAZER MAIS COISAS AQUI */
}

@end
