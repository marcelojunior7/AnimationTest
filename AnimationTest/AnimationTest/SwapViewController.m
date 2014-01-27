//
//  SwapViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 27/01/14.
//  Copyright (c) 2014 RodPrestes. All rights reserved.
//

#import "SwapViewController.h"

@implementation SwapViewController

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
    
    [[_viewItem layer] setBorderWidth:1];
    [[_viewItem layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    [[_viewItem layer] setBorderWidth:1.5f];

    [[_viewItem layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_viewItem layer] setShadowOpacity:0.8];
    [[_viewItem layer] setShadowRadius:3.0];
    [[_viewItem layer] setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [_viewItem removeFromSuperview];
    [self.view insertSubview:_viewItem aboveSubview:_viewSwap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)btnSwap:(id)sender
{
    [self performSelector:@selector(floatItemView) withObject:nil];
    
    [UIView transitionWithView:_viewSwap
                      duration:1
                       options:_isFlipped ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                    }
                    completion:^(BOOL finished)
                    {
                        [self performSelector:@selector(returnToOriginalPosition) withObject:nil];
                        _isFlipped = !_isFlipped;
                    }];
}

- (void)floatItemView
{
    [UIView animateWithDuration:0.3 animations:^ {
        [_viewItem setFrame:CGRectMake(_viewItem.frame.origin.x -25,
                                       _viewItem.frame.origin.x -25,
                                       150, 150)];
        
        [[_viewItem layer] setShadowOpacity:0.4];
    } completion:nil];
}

- (void)returnToOriginalPosition
{
    [UIView animateWithDuration:0.3 animations:^ {
        [_viewItem setFrame:CGRectMake(_viewItem.frame.origin.x +25,
                                       _viewItem.frame.origin.x +25,
                                       100, 100)];
        
        [[_viewItem layer] setShadowOpacity:0.8];
    } completion:nil];
}

@end
