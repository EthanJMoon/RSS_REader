//
//  Data.m
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import "Data.h"

@implementation Data

-(id)init{
    self = [super init];
    self.name = nil;
    self.smallImageURL = nil;
    self.largeImageURL = nil;
    self.smallImage = nil;
    self.largeImage = nil;
    self.summary = nil;
    self.title = nil;
    self.artist = nil;
    return self;
}

@end
