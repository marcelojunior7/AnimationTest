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
    
    // VARIABLES INITIALIZATION ============================================================================================
    _viewAlerta = [[UIView alloc] init];
    _viewAnimation = [[UIView alloc] init];
    
    _shouldRotateDeviceImage = NO;
    _isRotatingDeviceImage = NO;
    _isTapped = NO;
    
    _viewWidth = self.view.bounds.size.width;
    _viewHeight = self.view.bounds.size.height;
    
    _sidescrollTimer = nil;
    
    
    // AUDIO VARIABLES INITIALIZATION ============================================================================================
    NSString *audioFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"JumpFX.mp3"];
    NSData *audioData = [NSData dataWithContentsOfMappedFile:audioFile];
    
    NSError *err;
    _playerJump = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:audioData error:&err];
    _playerJump.numberOfLoops = 1;
    
    _playerJump.delegate = self;
    [_playerJump setEnableRate:NO];
    
    
    // ACTION LISTENER  ====================================================================================================
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    
    // ANIMATION INITIALIZATION ============================================================================================
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


#pragma mark - orientation

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
    _viewWidth = self.view.bounds.size.width;
    _viewHeight = self.view.bounds.size.height;
    
    if(fromInterfaceOrientation == 0 || fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        [self createAnimationView];
    }
    else
    {
        [self showPortraitAlert];
    }
}


#pragma mark - Alerta

- (void)showPortraitAlert
{
    [_viewAlerta setFrame:CGRectMake(_viewWidth / 2 - 75, _viewHeight / 2 - 100, 150, 150)];
    
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


#pragma mark - Animation

- (void)createAnimationView
{
    // CONTAINER ============================================================================
    UIView *viewAnimation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    [viewAnimation setBackgroundColor:[UIColor clearColor]];
    _viewAnimation = viewAnimation;
    [self.view addSubview:viewAnimation];
    
    
    // BACK =================================================================================
    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
    [back setFrame:CGRectMake(0, 0, _viewWidth, _viewHeight)];
    [_viewAnimation addSubview:back];
    
    
    // GROUND ===============================================================================
    UIView *ground = [[UIView alloc] initWithFrame:CGRectMake(0, _viewHeight - 30, _viewWidth * 3, 30)];
    
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
    animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_viewWidth, _viewHeight - 75, 55, 55)];
    
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.3;
    
    [_viewAnimation addSubview:animationImageView];
    [animationImageView startAnimating];
    
    // ANIMATION ===========================================================================
    _sidescrollTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0) target:self selector:@selector(scrollGround) userInfo:nil repeats:YES];
    
    [UIView animateWithDuration:1.5 animations:^
     {
        [[[_viewAnimation subviews] objectAtIndex:2] setFrame:CGRectMake(_viewWidth - 55, _viewHeight - 75, 55, 55)];
     }
    completion:^(BOOL finished)
     {
        [self performSelector:@selector(moveSpritePositionAtBegining) withObject:nil afterDelay:1.5];
     }
    ];
}

- (void)scrollGround
{
    float oldX = _ground.center.x + 3.0;
    float newX = oldX;
    
    if (oldX > 620.0)
    {
        newX = 200;
    }
    
    _ground.center = CGPointMake(newX, _ground.center.y);
}

- (void)moveSpritePositionAtBegining
{
    [UIView animateWithDuration:5.5 animations:^ {
         [[[_viewAnimation subviews] objectAtIndex:2] setFrame:CGRectMake(_viewWidth / 2 - 55, _viewHeight - 75, 55, 55)];
     } completion:nil];
}


#pragma mark - actions

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchLocation = [recognizer locationInView:[recognizer.view superview]];
    
    if (CGRectContainsPoint([[[_viewAnimation subviews] objectAtIndex:2] frame], touchLocation)) // TAP ON SPRITE
    {
        if (!_isTapped)
        {
            _currentX = [[[_viewAnimation subviews] objectAtIndex:2] frame].origin.x;
            _isTapped = YES;
            NSArray *imageNames = @[@"sonic-jumping-1.png", @"sonic-jumping-2.png", @"sonic-jumping-3.png", @"sonic-jumping-4.png", @"sonic-jumping-5.png", @"sonic-jumping-6.png"];
            
            NSMutableArray *images = [[NSMutableArray alloc] init];
            
            for (int i = 0; i < imageNames.count; i++)
            {
                [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
            }
            
            UIImageView *animationImageView = [[UIImageView alloc] init];
            animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_currentX, [[[_viewAnimation subviews] objectAtIndex:2] frame].origin.y, 50, 55)];
            
            animationImageView.animationImages = images;
            animationImageView.animationDuration = 0.3;
            
            [[[_viewAnimation subviews] objectAtIndex:2] removeFromSuperview];
            [_viewAnimation addSubview:animationImageView];
            [animationImageView startAnimating];
            
            [UIView animateWithDuration:0.7 animations:^
             {
                 [_playerJump play];
                 [animationImageView setFrame:CGRectMake(_currentX - 5, _viewHeight / 2, 50, 55)];
             }
            completion:^(BOOL finished)
             {
                 [UIView animateWithDuration:0.6 animations:^
                  {
                      [animationImageView setFrame:CGRectMake(_currentX, _viewHeight -75, 50, 55)];
                  }
                 completion:^(BOOL finished)
                  {
                      [UIView animateWithDuration:0.5 animations:^
                       {
                           [animationImageView setFrame:CGRectMake(_currentX, _viewHeight - (_viewHeight / 2), 55, 55)];
                           
                           NSArray *landingImageNames = @[@"sonic-landing-1.png", @"sonic-landing-2.png", @"sonic-landing-3.png"];
                           
                           NSMutableArray *landingImages = [[NSMutableArray alloc] init];
                           
                           for (int i = 0; i < landingImageNames.count; i++)
                           {
                               [landingImages addObject:[UIImage imageNamed:[landingImageNames objectAtIndex:i]]];
                           }
                           
                           UIImageView *landingAnimationImageView = [[UIImageView alloc] init];
                           landingAnimationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_currentX, _viewHeight - 75, 55, 55)];
                           
                           landingAnimationImageView.animationImages = landingImages;
                           landingAnimationImageView.animationDuration = 0.3;
                           
                           [animationImageView removeFromSuperview];
                           [_viewAnimation addSubview:landingAnimationImageView];
                       }
                      completion:^(BOOL finished)
                       {
                           NSArray *spriteImageNames = @[@"sonic-running-1.png", @"sonic-running-2.png", @"sonic-running-3.png", @"sonic-running-4.png", @"sonic-running-5.png"];
                           
                           NSMutableArray *spriteImages = [[NSMutableArray alloc] init];
                           
                           for (int i = 0; i < spriteImageNames.count; i++)
                           {
                               [spriteImages addObject:[UIImage imageNamed:[spriteImageNames objectAtIndex:i]]];
                           }
                           
                           UIImageView *spriteAnimationImageView = [[UIImageView alloc] init];
                           spriteAnimationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_currentX, _viewHeight - 75, 55, 55)];
                           
                           spriteAnimationImageView.animationImages = spriteImages;
                           spriteAnimationImageView.animationDuration = 0.3;
                           
                           [[[_viewAnimation subviews] objectAtIndex:2] removeFromSuperview];
                           [_viewAnimation addSubview:spriteAnimationImageView];
                           [spriteAnimationImageView startAnimating];
                           _isTapped = NO;
                       }
                      ];
                  }
                 ];
             }
            ];
        }
    }
}

@end
