//
//  MainViewController.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Network.h"
#import "SecondViewController.h"
#import "FavoriteViewController.h"

@class SecondViewController;
@class FavoriteViewController;

@interface MainViewController : UIViewController<NetworkProtocal,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *maskScreen;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) SecondViewController *secondViewController;
@property (strong, nonatomic) FavoriteViewController *favoriteViewController;

@end
