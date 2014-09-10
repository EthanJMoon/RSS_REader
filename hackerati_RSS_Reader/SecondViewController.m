//
//  SecondViewController.m
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (strong, nonatomic)UIBarButtonItem *saveFavorite;

@end

@implementation SecondViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.delegate = [[UIApplication sharedApplication]delegate];
    
    self.title = self.oneData.name;
    self.largeImageView.image = self.oneData.largeImage;
    self.summaryTextView.text = self.oneData.summary;
    self.artistLabel.text = self.oneData.artist;
    self.titleLabel.text = self.oneData.title;
    
    self.saveFavorite = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavorite)];
    UIBarButtonItem *shareItems = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareItemsAction)];
    NSArray *barButtonItems = [[NSArray alloc]initWithObjects:self.saveFavorite,shareItems, nil];
    self.navigationItem.rightBarButtonItems = barButtonItems;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Feed"];
    NSError *error = nil;
    NSArray *datas = [self.delegate.managedObjectContext executeFetchRequest:request error:&error];
    for(Data *item in datas){
        if([item.name isEqualToString:self.oneData.name]){
            self.saveFavorite.enabled = NO;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addToFavorite{
    Feed *tempFeed = [NSEntityDescription insertNewObjectForEntityForName:@"Feed" inManagedObjectContext:self.delegate.managedObjectContext];
    if (tempFeed != nil){
        tempFeed.name = self.oneData.name;
        tempFeed.summary = self.oneData.summary;
        tempFeed.title = self.oneData.title;
        tempFeed.artist = self.oneData.artist;
        tempFeed.largeImage = UIImagePNGRepresentation(self.oneData.largeImage);
        tempFeed.smallImae = UIImagePNGRepresentation(self.oneData.smallImage);
        NSError *error = nil;
        if([self.delegate.managedObjectContext save:&error]){
            NSLog(@"Save Success \n");
            self.saveFavorite.enabled = NO;
            UIAlertView *savedAlert = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Saved to Favorite" delegate:self cancelButtonTitle:@"close" otherButtonTitles: nil];
            [savedAlert show];
        } else{
            NSLog(@"Save UNsuccess \n");
        }
    }
    
}

-(void)shareItemsAction{
    NSArray *itemsToShare = [[NSArray alloc]initWithObjects:self.oneData.name,self.oneData.artist,self.oneData.title,self.oneData.summary, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    
    [self presentViewController:activityViewController animated:YES completion:^{
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
