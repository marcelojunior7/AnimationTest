//
//  FlipViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 24/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import "FlipViewController.h"
#import "FlipCell.h"

@interface FlipViewController ()

@end

@implementation FlipViewController

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
    
    _viewsFlip = [[NSMutableArray alloc] init];
    _isFlipped = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int tiles = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        tiles = 88;
    }
    else
    {
        tiles = 24;
    }
    
    return tiles;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlipCell" forIndexPath:indexPath];
    
    [_viewsFlip addObject:[cell viewItem]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self flipOrdered:@"0"];
}


- (void)flipOrdered:(NSString *)valor
{
    int indice = [valor intValue];
    
    UIColor *cor = [[UIColor alloc] init];

    if (_isFlipped)
    {
        cor = [UIColor whiteColor];
    }
    else
    {
        cor = [UIColor lightGrayColor];
    }
    
    [[_viewsFlip objectAtIndex:indice] setBackgroundColor:cor];
    
    [UIView transitionWithView:[_viewsFlip objectAtIndex:indice]
                        duration:0.5
                       options:_isFlipped ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                        if (!([_viewsFlip count] - 1 == indice))
                        {
                            [self performSelector:@selector(flipOrdered:) withObject:[NSString stringWithFormat:@"%d", indice + 1] afterDelay:0.05];
                        }
                        else
                        {
                            _isFlipped = !_isFlipped;
                        }
                    }
    completion:nil];
}

@end
