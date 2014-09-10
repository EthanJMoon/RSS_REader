//
//  Network.m
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import "Network.h"

@implementation Network

static Network* singletonNetwork =nil;

+(Network*)singletonNetworkInit{
    if (singletonNetwork == nil){
        singletonNetwork = [[Network alloc]init];
    }
    return singletonNetwork;
}

-(id)init{
    self = [super init];
    return self;
}

-(void)getJSonData{
    
    __block NSMutableArray *dataArray = [[NSMutableArray alloc]initWithObjects: nil];
    __block NSString *title = nil;
    
    NSString *urlString = @"http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topgrossingapplications/sf=143441/limit=25/json";
    
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        if (connectionError == nil){
            NSError *error;
            NSDictionary *dataDictionary1 = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            [dataDictionary1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                NSDictionary *dataDictionary2 = (NSDictionary*)obj;
                [dataDictionary2 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                    if ([key isEqual:@"entry"]){
                        NSArray *tempArray1 = (NSArray*)obj;
                        [tempArray1 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                            NSDictionary *dataDictionary3 = (NSDictionary*)obj;
                            __block Data *tempData = [[Data alloc]init];
                            [dataDictionary3 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
                                if ([key isEqual:@"im:name"]){
                                    NSDictionary *dataDictionary4 = (NSDictionary*)obj;
                                    tempData.name = (NSString*)[dataDictionary4 objectForKey:@"label"];
                                }else if ([key isEqual:@"im:image"]){
                                    NSArray *dataArray1 = (NSArray*)obj;
                                    NSDictionary *tempDic1 = (NSDictionary*)[dataArray1 objectAtIndex:0];
                                    tempData.smallImageURL = (NSString*)[tempDic1 objectForKey:@"label"];
                                    NSDictionary *tempDic2 = (NSDictionary*)[dataArray1 objectAtIndex:2];
                                    tempData.largeImageURL = (NSString*)[tempDic2 objectForKey:@"label"];
                                    
                                    NSURLRequest *urlRequest1 = [[NSURLRequest alloc]initWithURL: [[NSURL alloc]initWithString:tempData.smallImageURL]];
                                    [NSURLConnection sendAsynchronousRequest:urlRequest1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                        if (connectionError == nil){
                                            UIImage *tempImage = [[UIImage alloc]initWithData:data];
                                            tempData.smallImage = tempImage;
                                            [self.delegate receivedNetworkdata:dataArray withTitle:title];
                                        }
                                    }];
                                    
                                    NSURLRequest *urlRequest2 = [[NSURLRequest alloc]initWithURL: [[NSURL alloc]initWithString:tempData.largeImageURL]];
                                    [NSURLConnection sendAsynchronousRequest:urlRequest2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                                        if (connectionError == nil){
                                            UIImage *tempImage = [[UIImage alloc]initWithData:data];
                                            tempData.largeImage = tempImage;
                                        }
                                    }];
                                } else if ([key isEqual:@"summary"]){
                                    NSDictionary *dataDictionary5 = (NSDictionary*)obj;
                                    tempData.summary = (NSString*)[dataDictionary5 objectForKey:@"label"];
                                } else if ([key isEqual:@"title"]){
                                    NSDictionary *dataDictionary6 = (NSDictionary*)obj;
                                    tempData.title = (NSString*)[dataDictionary6 objectForKey:@"label"];
                                } else if ([key isEqual:@"im:artist"]){
                                    NSDictionary *dataDictionary7 = (NSDictionary*)obj;
                                    tempData.artist = (NSString*)[dataDictionary7 objectForKey:@"label"];
                                }
                            }];
                            [dataArray addObject:tempData];
                        }];
                    } else if ([key isEqual:@"title"]){
                        NSDictionary *dataDictionary8 = (NSDictionary*)obj;
                        title = [dataDictionary8 objectForKey:@"label"];
                    }
                }];
            }];
            
            [self.delegate receivedNetworkdata:dataArray withTitle:title];
        }
    }];
}

@end
