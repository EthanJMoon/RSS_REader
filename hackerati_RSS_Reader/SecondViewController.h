//
//  SecondViewController.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "AppDelegate.h"
#import "Feed.h"

@class AppDelegate;

@interface SecondViewController : UIViewController

@property (strong, nonatomic) Data *oneData;
@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) AppDelegate *delegate;

@end