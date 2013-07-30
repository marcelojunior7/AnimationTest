//
//  ImageAnimationViewController.h
//  Obj-C Tests
//
//  Created by Rodrigo Prestes on 26/07/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ImageAnimationViewController : UIViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblVelocidade;
@property (weak, nonatomic) IBOutlet UILabel *lblValor;
@property (weak, nonatomic) IBOutlet UILabel *lblPausa;
@property (weak, nonatomic) IBOutlet UILabel *lblModo;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic) int animationSpeed;
@property (nonatomic) bool isPlay, isRealPlaying, wasDraggedPortrait, wasDraggedLandscape, dragging, swapOnNew;
@property (nonatomic) float oldX, oldY, newXP, newYP, newXL, newYL;

@property (strong, nonatomic) UIView *image;

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioPlayer *playerReal;
@property (strong, nonatomic) AVAudioPlayer *playerPause;

- (IBAction)sliderChanged:(id)sender;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnTrocar:(id)sender;

@end
