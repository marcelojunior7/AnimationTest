//
//  DetailViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 30/07/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
