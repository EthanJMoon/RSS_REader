//
//  FavoriteViewController.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SecondViewController.h"

@class SecondViewController;
@class AppDelegate;

@interface FavoriteViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) AppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfDatas;
@property (strong, nonatomic) SecondViewController *secondViewController;

@end
