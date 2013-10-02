//
//  MainViewController.m
//  AnimationTest
//
//  Created by Rodrigo Prestes on 11/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import "MainViewController.h"
#import "MainCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    _arrayButtons = [[NSMutableArray alloc] init];
    
    [_arrayButtons addObject:@"Gangnam Style"];
    [_arrayButtons addObject:@"Side Scroll"];
    [_arrayButtons addObject:@"Parallax"];
    [_arrayButtons addObject:@"Flip"];
    [_arrayButtons addObject:@"Fade"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma Collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arrayButtons count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCell" forIndexPath:indexPath];
    
    CALayer *viewLayer = [[cell viewButton] layer];
    
    // ADDING SHADOW ==========================================================================
    [viewLayer setShadowColor:[[UIColor blackColor] CGColor]];
    [viewLayer setShadowOffset:CGSizeMake(0,4)];
    [viewLayer setShadowOpacity:0.3];
    
    // MAKING ROUND ===========================================================================
    [viewLayer setCornerRadius:2.9];
    
    // SETTING TEXT ===========================================================================
    [[cell lblButton] setText:[_arrayButtons objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ opened", [_arrayButtons objectAtIndex:indexPath.row]);
    [self performSegueWithIdentifier:[_arrayButtons objectAtIndex:indexPath.row] sender:self];
}

@end
