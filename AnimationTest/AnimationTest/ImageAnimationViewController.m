//
//  ImageAnimationViewController.m
//  Obj-C Tests
//
//  Created by Rodrigo Prestes on 26/07/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import "ImageAnimationViewController.h"

@interface ImageAnimationViewController ()

@end

@implementation ImageAnimationViewController

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
    
    _animationSpeed = 1;
    _isPlay = NO;
    _isRealPlaying = NO;
    _dragging = NO;
    _wasDraggedPortrait = NO;
    _wasDraggedLandscape = NO;
    _swapOnNew = NO;
    
    _oldX = 0;
    _oldY = 0;
    
    _newXP = 0;
    _newYP = 0;
    _newXL = 0;
    _newYL = 0;
    
    [_lblPausa setHidden:YES];
    [_lblModo setHidden:YES];
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget : self action : @selector (handleDoubleTap:)];
    [doubleTap setDelaysTouchesBegan: YES];
    [doubleTap setNumberOfTapsRequired: 2];
    [self.view addGestureRecognizer: doubleTap];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _lblVelocidade.text = [NSString stringWithFormat:@"Velocidade: %d", _animationSpeed];
        
        //[UIView animateWithDuration:0.2 animations:^{[_lblValor setAlpha:0];}completion:nil];
        [_lblValor setAlpha:0];
    }
    else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        _lblVelocidade.text = @"Velocidade:";
        _lblValor.text = [NSString stringWithFormat:@"%d", _animationSpeed];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma image

- (void)imageAnimationWithFade:(bool)fade
{
    // Load images
    NSArray *imageNames = @[@"win_1.png", @"win_2.png", @"win_3.png", @"win_4.png",
                            @"win_5.png", @"win_6.png", @"win_7.png", @"win_8.png",
                            @"win_9.png", @"win_10.png", @"win_11.png", @"win_12.png",
                            @"win_13.png", @"win_14.png", @"win_15.png", @"win_16.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < imageNames.count; i++)
    {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
    
    UIImageView *animationImageView = [[UIImageView alloc] init];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _lblVelocidade.text = [NSString stringWithFormat:@"Velocidade: %d", _animationSpeed];
        
        [UIView animateWithDuration:0.1 animations:^{[_lblValor setAlpha:0];}completion:nil];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            if (_wasDraggedPortrait)
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_newXP, _newYP, 320, 545)];
            }
            else
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(230, 250, 320, 545)];
            }
        }
        else
        {
            if (_wasDraggedPortrait)
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_newXP, _newYP, 180, 345)];
            }
            else
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(63, 60, 180, 345)];
            }
        }
    }
    else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        _lblVelocidade.text = @"Velocidade:";
        _lblValor.text = [NSString stringWithFormat:@"%d", _animationSpeed];
        
        [UIView animateWithDuration:0.1 animations:^{[_lblValor setAlpha:1];}completion:nil];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            if (_wasDraggedLandscape)
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_newXL, _newYL, 180, 350)];
            }
            else
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(630, 200, 180, 350)];
            }
        }
        else
        {
            if (_wasDraggedLandscape)
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_newXL, _newYL, 90, 180)];
            }
            else
            {
                animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 60, 90, 180)];
            }
        }
    }
    
    animationImageView.animationImages = images;
    
    switch (_animationSpeed)
    {
        case 0:
            animationImageView.animationDuration = 2;
            break;
            
        case 1:
            animationImageView.animationDuration = 1;
            break;
            
        case 2:
            animationImageView.animationDuration = 0.4;
            break;
            
        default:
            break;
    }
    
    
    if (fade)
    {
        [animationImageView setAlpha:0];
    }
    
    [self.view addSubview:animationImageView];
    [animationImageView startAnimating];
    
    
    _image = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
    
    if (fade)
    {    
        [UIView animateWithDuration:0.2 animations:^{[animationImageView setAlpha:1];} completion:nil];
    }
}

- (void)reloadImageAnimationWithFade:(bool)fade
{
    [UIView animateWithDuration:0.2 animations:^
     {
         if (fade)
         {
             [[[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1] setAlpha:0.0];
         }
     }
    completion:^(BOOL finished)
     {
         [[[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1] removeFromSuperview];
         [self imageAnimationWithFade:fade];
     }
    ];
}


#pragma slider

- (IBAction)sliderChanged:(id)sender
{
    _animationSpeed = [_slider value];
    
    [self reloadImageAnimationWithFade:NO];
    [self changeMusicTempo];
}


#pragma buttons

- (IBAction)btnPlay:(id)sender
{
    UIButton *botao = sender;
    
    if (_isPlay)
    {
        [_player pause];
        [_playerReal pause];
        
        UIImageView *animationImageView = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
        
        [UIView animateWithDuration:0.4 animations:^
         {
             [_lblValor setAlpha:0];
             [animationImageView setAlpha:0];
         }
                         completion:^(BOOL finished)
         {
             [animationImageView stopAnimating];
         }
         ];
        
        [botao setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
        [self playPausa];

        [_lblPausa setHidden:NO];
        _isPlay = NO;
    }
    else
    {
        if (_playerReal == nil && _player == nil)
        {
            [self imageAnimationWithFade:YES];
            
            [self prepareRealSound];
            [self playSound];
            
            [self startPlaying];
        }
        else
        {
            [_player play];
            [_playerReal play];
            
            UIImageView *animationImageView = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
            [animationImageView startAnimating];
            
            [UIView animateWithDuration:0.4 animations:^
             {
                [animationImageView setAlpha:1];
                 
                 UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
                 if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
                 {
                     [_lblValor setAlpha:1];
                 }
             }
            completion:nil];
        }
        
        [botao setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        
        [_lblPausa setHidden:YES];
        _isPlay = YES;
    }
}

- (IBAction)btnTrocar:(id)sender
{
    [self changeMusic];
}


#pragma orientation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (_isPlay)
    {
        [self reloadImageAnimationWithFade:YES];
        
        if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
        {
            [UIView animateWithDuration:0.2 animations:^
             {
                 [_lblValor setAlpha:1];
             }
            completion:nil];
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
}


#pragma music

- (void)playSound
{
    NSString *audioFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"GS8B.mp3"];
    NSData *audioData = [NSData dataWithContentsOfMappedFile:audioFile];
    
    NSError *err;
    _player = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:audioData error:&err];
    _player.numberOfLoops = -1;
    
    _player.delegate = self;
    [_player setEnableRate:YES];
    
//    if (_player == nil)
//    {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Erro ao reproduzir audio" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//	else
//    {
//        [_player play];
//    }
}

- (void)prepareRealSound
{
    NSString *audioFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"GS.m4a"];
    NSData *audioData = [NSData dataWithContentsOfMappedFile:audioFile];
    
    NSError *err;
    _playerReal = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:audioData error:&err];
    _playerReal.numberOfLoops = -1;
    
    _playerReal.delegate = self;
    [_playerReal setEnableRate:YES];
}

- (void)startPlaying
{
    if (_player == nil)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Erro ao reproduzir audio" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
	else
    {
        [_player setVolume:0.8];
        [_player play];
    }
    
    if (_playerReal == nil)
    {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Erro ao reproduzir audio" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
	else
    {
        [_playerReal setVolume:0];
        [_playerReal play];
    }
}

- (void)changeMusicTempo
{
    float musicSpeed = 0.6;
    
    if (_animationSpeed > 0.5)
    {
        musicSpeed = _animationSpeed;
    }
    
//    NSLog(@"%f", musicSpeed);
    
//    if (_isRealPlaying)
//    {
//        [_playerReal setRate:musicSpeed];
//    }
//    else
//    {
//        [_player setRate:musicSpeed];
//    }
    
    [_playerReal setRate:musicSpeed];
    [_player setRate:musicSpeed];
}

- (void)playPausa
{
    NSString *audioFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"PauseFX.m4a"];
    NSData *audioData = [NSData dataWithContentsOfMappedFile:audioFile];
    
    NSError *err;
    _playerPause = [(AVAudioPlayer*)[AVAudioPlayer alloc] initWithData:audioData error:&err];
    
    _playerPause.numberOfLoops = 0;
    
    _playerPause.delegate = self;
    [_playerPause setEnableRate:YES];
    [_playerPause setVolume:0.6];
    
    [_playerPause play];
}

- (void)changeMusic
{
    if (_isRealPlaying)
    {
        [_playerReal setVolume:0];
        [_player setVolume:0.8];
    }
    else
    {
        [_player setVolume:0];
        [_playerReal setVolume:0.45];
    }
    
    _isRealPlaying = !_isRealPlaying;
    [self changeMode];
}

/*
-(void)changeMusic
{
    if (_isRealPlaying)
    {
        [_playerReal pause];
        
        NSTimeInterval playTime = _playerReal.currentTime;
        
        [_player setCurrentTime:playTime];
        [_player play];
    }
    else
    {
        [_player pause];
        
        NSTimeInterval playTime = _player.currentTime;
        
        [_playerReal setCurrentTime:playTime];
        [_playerReal play];
    }
    
    _isRealPlaying = !_isRealPlaying;
}
 */


#pragma touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:_image];
    CGPoint touchGeral = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_image.frame, touchGeral))
    {
        _dragging = YES;
        _oldX = touchLocation.x;
        _oldY = touchLocation.y;
    }
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        _wasDraggedPortrait = YES;
    }
    else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        _wasDraggedLandscape = YES;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _dragging = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (_dragging)
    {
        CGRect frame = _image.frame;
        
        if(orientation == 0 || orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            _newXP = touchLocation.x - _oldX; // _image.frame.origin.x + touchLocation.x - _oldX;
            _newYP = touchLocation.y - _oldY; //  _image.frame.origin.y + touchLocation.y - _oldY;
            
            frame.origin.x = _newXP;
            frame.origin.y = _newYP;
        }
        else if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
        {
            _newXL = touchLocation.x - _oldX;
            _newYL = touchLocation.y - _oldY;
            
            frame.origin.x = _newXL;
            frame.origin.y = _newYL;
        }
        
        _image.frame = frame;
    }
}


#pragma handlers

- (void)handleDoubleTap:(UIGestureRecognizer*)sender
{
    if (_isPlay)
    {
        UIImageView *animationImageView = [[self.view subviews] objectAtIndex:[[self.view subviews] count] - 1];
        
        [UIView animateWithDuration:0.4 animations:^
         {
             [_player pause];
             [_playerReal pause];
             
             [_lblValor setAlpha:0];
             [animationImageView setAlpha:0];
         }
                         completion:^(BOOL finished)
         {
             [animationImageView stopAnimating];
             [_lblPausa setHidden:NO];
         }
         ];
        
        [self playPausa];
        
        [_btnPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
        _isPlay = NO;
    }
}


#pragma modo

- (void)changeMode
{
    [_lblModo setAlpha:0];
    [_lblModo setHidden:NO];
    
    if (_swapOnNew)
    {
        _lblModo.text = @"-  Modo 8 bits  -";
    }
    else
    {
        _lblModo.text = @"-  Modo KPop  -";
    }
    
    _swapOnNew = !_swapOnNew;
    
    [UIView animateWithDuration:0.1 animations:^
     {
         [_lblModo setAlpha:1];
     }
    completion:^(BOOL finished)
     {
         [self performSelector:@selector(hideMode) withObject:nil afterDelay:3.5];
     }
    ];
}

- (void)hideMode
{
    [UIView animateWithDuration:0.4 animations:^
     {
         [_lblModo setAlpha:0];
     }
    completion:nil];
}


@end
