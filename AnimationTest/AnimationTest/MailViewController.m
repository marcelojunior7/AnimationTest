//
//  MailViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 27/01/14.
//  Copyright (c) 2014 RodPrestes. All rights reserved.
//

#import "MailViewController.h"

@implementation MailViewController


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
    
    [self initLayout];
    [self createBorders];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma Layout

- (void)initLayout
{
    [_viewMail setClipsToBounds:YES];
}

- (void)createBorders
{
    [[_viewEnvelopeTop layer] setBorderWidth:1.5];
    [[_viewEnvelopeTop layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [[_viewEnvelopeBot layer] setBorderWidth:1.5];
    [[_viewEnvelopeBot layer] setBorderColor:[UIColor blackColor].CGColor];
}


#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_started && !_finished)
    {
        // DO FOLDING + SEND ANIMATION
        [self closeMailAndSend];
        
        _started = YES;
        _finished = NO;
    }
    else if (!_started && _finished)
    {
        // FADE THING TO REPLAY ANIMATION
        [self fadeAndReturnToStart];
        
        _started = NO;
        _finished = NO;
    }
}


#pragma mark - Animation

- (void)closeMailAndSend
{
    [UIView animateWithDuration:0.9 animations:^
     {
         //[_labelMailText setFrame:CGRectMake(0, -75, 300, _labelMailText.frame.size.height)];
//         [_labelMailText ]
         
         //[_viewEnvelopeTop setFrame:CGRectMake(0, 0, 300, 150)];
         [_viewEnvelopeBot setFrame:CGRectMake(0, 75, 300, 150)];

         [_viewMail setFrame:CGRectMake(((self.view.frame.size.width / 2) - 150),
                                        ((self.view.frame.size.height / 2) - 150),
                                        300, 300)];
     }
    completion:^(BOOL finished) { [self envelopeRotate]; }];
}

- (void)envelopeRotate
{
    [UIView animateWithDuration:0.3 animations:^
     {
         CATransform3D transform = CATransform3DIdentity;
         transform.m34 = 1.0f/ -500.0f;
         transform = CATransform3DRotate(transform, 45 * M_PI / 180.0f, 0, 1, 0);
        
         [_viewMail layer].transform = transform;
     }
    completion:^(BOOL finished) { [self sendMail]; }];
}

- (void)sendMail
{
    [UIView animateWithDuration:0.6 animations:^
     {
         [_viewMail setFrame:CGRectMake(-310, -310, 300, 300)];
     }
    completion:^(BOOL finished) { _finished = YES; }];
}

- (void)fadeAndReturnToStart
{
    
}


@end
