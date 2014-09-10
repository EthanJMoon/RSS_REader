//
//  FavoriteViewController.m
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

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
    self.title = @"Favorites";
    self.delegate = [[UIApplication sharedApplication]delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Feed"];
    NSError *error = nil;
    self.arrayOfDatas = [self.delegate.managedObjectContext executeFetchRequest:request error:&error];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.arrayOfDatas != nil)
        return [self.arrayOfDatas count];
    else
        return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    Feed* tempFeed = [self.arrayOfDatas objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithData:tempFeed.smallImae];
    cell.textLabel.text = tempFeed.name;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Data *tempData = [[Data alloc]init];
    Feed* tempFeed = [self.arrayOfDatas objectAtIndex:indexPath.row];
    tempData.smallImage = [UIImage imageWithData:tempFeed.smallImae];
    tempData.largeImage = [UIImage imageWithData:tempFeed.largeImage];
    tempData.name = tempFeed.name;
    tempData.summary = tempFeed.summary;
    tempData.title = tempFeed.title;
    tempData.artist = tempFeed.artist;
    self.secondViewController = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    self.secondViewController.oneData = tempData;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.secondViewController animated:YES];
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