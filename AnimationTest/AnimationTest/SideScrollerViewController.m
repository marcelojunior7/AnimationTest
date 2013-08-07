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
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
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
    if(toInterfaceOrientation == 0 || toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        [self showPortraitAlert];
    }
}


#pragma render

- (void)showPortraitAlert
{
    [[[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1] removeFromSuperview];
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    [viewContainer setBackgroundColor:[UIColor lightGrayColor]];
    
    [viewContainer.layer setMasksToBounds:YES];
    [viewContainer.layer setCornerRadius:2.9];
    
    
}


@end
