//
//  Feed.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSData * largeImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * smallImae;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;

@end
