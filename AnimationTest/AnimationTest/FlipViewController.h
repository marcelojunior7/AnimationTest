//
//  FlipViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 24/09/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionFlip;

@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray *viewsFlip;

@property (nonatomic) bool isFlipped;

@end
