//
//  MainViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 11/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *arrayButtons;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionButtons;

@end
