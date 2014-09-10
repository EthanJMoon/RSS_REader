//
//  MainViewController.m
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(goToFavorite)];
    
    self.maskScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320.0f, 568.0f)];
    self.maskScreen.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.75f];
    [self.view addSubview:self.maskScreen];
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.activityView];
    [self.activityView startAnimating];
    
    self.dataArray = nil;
    Network *net= [Network singletonNetworkInit];
    net.delegate = self;
    [net getJSonData];
}

-(void)goToFavorite{
    self.favoriteViewController = [[FavoriteViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:self.favoriteViewController animated:YES];
}

-(void)receivedNetworkdata:(NSArray*)data withTitle:(NSString*)title{
    NSLog(@"receivedNetworkdata\n");
    self.maskScreen.hidden = YES;
    [self.activityView stopAnimating];
    self.dataArray = data;
    self.title = title;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int x = 0;
    if (self.dataArray != nil)
        x = [self.dataArray count];
    return x;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Data *tempData = (Data*)[self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = tempData.name;
    
    if (tempData.smallImage != nil)
        cell.imageView.image = tempData.smallImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.secondViewController = [[SecondViewController alloc]initWithNibName:nil bundle:nil];
    self.secondViewController.oneData = (Data*)[self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.secondViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

