//
//  MasterViewController.h
//  AnimationTest
//
//  Created by Rodrigo Prestes on 30/07/13.
//  Copyright (c) 2013 RodPrestes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
