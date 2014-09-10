//
//  Network.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@protocol NetworkProtocal <NSObject>

-(void)receivedNetworkdata:(NSArray*)data withTitle:(NSString*)title;

@end

@interface Network : NSObject

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) id <NetworkProtocal> delegate;

+(Network*)singletonNetworkInit;
-(void)getJSonData;

@end
