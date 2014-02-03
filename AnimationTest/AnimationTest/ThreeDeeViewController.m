//
//  ThreeDeeViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 27/01/14.
//  Copyright (c) 2014 RodPrestes. All rights reserved.
//

#import "ThreeDeeViewController.h"

@implementation ThreeDeeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
//    CGFloat clampedOffset = fmaxf(-1.0f, fminf(1.0f, 0.0f));
//    CGFloat tilt = 0.0f;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0f/ -500.0f;
    
    CGFloat positionX = (touchLocation.x / 8);
    CGFloat positionY = (touchLocation.y / 16);
    
    CGFloat rotX = touchLocation.x < 0 ? 0.0f : positionX;
    rotX = positionX > 55 ? 55.0f : positionX;
    
    CGFloat rotY = touchLocation.x < 0 ? 0.0f : positionY;
    rotY = positionY > 55 ? 55.0f : positionY;
    
    transform = CATransform3DRotate(transform, rotX * M_PI / 180.0f, 0, 1, rotY * M_PI / 180.0f);
    //transform = CATransform3DTranslate(transform, -CGSizeZero.width, -CGSizeZero.height, 0.0f);
    //transform = CATransform3DTranslate(transform, touchLocation.x, 0.0f, touchLocation.y);
    
    self.view.layer.transform = transform;
    
    //self.view.superview.layer.transform = CATransform3DRotate(transform, -clampedOffset * M_PI_2 * tilt, 0.0f, 1.0f, 0.0f);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
