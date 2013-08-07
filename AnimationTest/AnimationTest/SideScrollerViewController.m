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
    
    _shouldRotateDeviceImage = NO;
    
    UIView *viewContainer = [[UIView alloc] init];
        
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        viewContainer = [[UIView alloc] initWithFrame:CGRectMake(90, 150, 150, 150)];
        [viewContainer setBackgroundColor:[UIColor clearColor]];
        
        [[self view] addSubview:viewContainer];
        [self showPortraitAlert];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma orientation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UIView *viewContainer = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
    
    if(toInterfaceOrientation == 0 || toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        [viewContainer removeFromSuperview];
        
        UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(90, 150, 150, 150)];
        [viewContainer setBackgroundColor:[UIColor clearColor]];
        
        [[self view] addSubview:viewContainer];
        
        [self showPortraitAlert];
    }
    else
    {
        if (viewContainer)
        {
            [UIView animateWithDuration:0.2 animations:^
             {
                 [viewContainer setAlpha:0];
             }
            completion:^(BOOL finished)
             {
//                 [viewContainer removeFromSuperview];
             }
            ];
        }
    }
}


#pragma render

- (void)showPortraitAlert
{
//    [[[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1] removeFromSuperview];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    [view setAlpha:0.4];
    
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:2.9];
    
    UIImageView *deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iPhone.png"]];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"Turn landscape to animate!"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setNumberOfLines:2];
    
    UIView *viewContainer = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
    
    [viewContainer setAlpha:0];
    
    [viewContainer addSubview:view];
    [viewContainer addSubview:deviceImage];
    [viewContainer addSubview:label];
    [label setBackgroundColor:[UIColor clearColor]];
    
    [label setFrame:CGRectMake(0, 95, 150, 40)];
    [deviceImage setFrame:CGRectMake(45, 15, 60, 65)];
    
    [UIView animateWithDuration:0.5 animations:^
     {
         [viewContainer setAlpha:1];
     }
    completion:nil];
    
    [self rotateDeviceImage];
}

- (void)rotateDeviceImage
{
    UIView *deviceImage = [[[[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1] subviews] objectAtIndex:1];
    
    [UIView animateWithDuration:0.3 animations:^
     {
         [deviceImage setTransform:CGAffineTransformMakeRotation(((90) * M_PI / 180.0))];
     }
    completion:^(BOOL finished)
     {
         [deviceImage setAlpha:0];
         
         [UIView animateWithDuration:0.3 animations:^
          {
              [deviceImage setTransform:CGAffineTransformMakeRotation(((0) * M_PI / 180.0))];
              [deviceImage setAlpha:0];
          }
         completion:^(BOOL finished)
          {
             [self rotateDeviceImage];
          }
         ];
     }
    ];
}


@end
