//
//  MailViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 27/01/14.
//  Copyright (c) 2014 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MailViewController : UIViewController

@property (nonatomic) bool started;
@property (nonatomic) bool finished;

@property (weak, nonatomic) IBOutlet UILabel *labelMailText;
@property (weak, nonatomic) IBOutlet UILabel *labelMailSent;

@property (weak, nonatomic) IBOutlet UIView *viewMail;

@property (weak, nonatomic) IBOutlet UIView *viewEnvelopeTop;
@property (weak, nonatomic) IBOutlet UIView *viewEnvelopeBot;

@end
