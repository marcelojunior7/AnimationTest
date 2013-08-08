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
    
    _viewHeight = 0;
    _viewWidth = 0;
    
    _sidescrollTimer = nil;
    
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
        _viewWidth = self.view.bounds.size.width;
        _viewHeight = self.view.bounds.size.height;
        
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
    
    if(_sidescrollTimer)
    {
        [_sidescrollTimer invalidate];
        _sidescrollTimer = nil;
    }
    
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
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(fromInterfaceOrientation == 0 || fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _viewWidth = self.view.bounds.size.width;
        _viewHeight = self.view.bounds.size.height;
        
        [self createAnimationView];
    }
    else
    {
        [self showPortraitAlert];
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
    UIView *viewAnimation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    [viewAnimation setBackgroundColor:[UIColor clearColor]];
    _viewAnimation = viewAnimation;
    [self.view addSubview:viewAnimation];
    
    
    // BACK =================================================================================
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
    [back setFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    [_viewAnimation addSubview:back];
    
    
    // GROUND ===============================================================================
    UIView *ground = [[UIView alloc] initWithFrame:CGRectMake(0, _viewHeight - 50, _viewWidth * 3, 50)];
    
    for (int i = 0; _viewWidth * 3 > i; i+=30)
    {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ground.png"]];
        [bg setFrame:CGRectMake(i, 0, 30, 30)];
        [ground addSubview:bg];
    }

    ground.center = CGPointMake(200, ground.center.y);
    
    [_viewAnimation addSubview:ground];
    _ground = ground;
    
    
    // SPRITE ===============================================================================
    NSArray *imageNames = @[@"sonic-running-1.png", @"sonic-running-2.png", @"sonic-running-3.png", @"sonic-running-4.png",
                            @"sonic-running-5.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < imageNames.count; i++)
    {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    UIImageView *animationImageView = [[UIImageView alloc] init];
    animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_viewWidth - 70, 220, 55, 55)];
    
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.3;
    
    [_viewAnimation addSubview:animationImageView];
    [animationImageView startAnimating];
    
    
    // ANIMATION ===========================================================================
    _sidescrollTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0) target:self selector:@selector(scrollGround) userInfo:nil repeats:YES];
    [self performSelector:@selector(moveSpritePosition) withObject:nil afterDelay:1.5];
}

-(void)scrollGround
{
    float oldX = _ground.center.x + 3.0;
    float newX = oldX;
    
    if (oldX > 620.0)
    {
        newX = 200;
    }
    
    _ground.center = CGPointMake(newX, _ground.center.y);
}

- (void)moveSpritePosition
{
    [UIView animateWithDuration:5.5 animations:^ {
         [[[_viewAnimation subviews] objectAtIndex:2] setFrame:CGRectMake(_viewWidth / 2, 220, 55, 55)];
     } completion:nil];
}

@end
