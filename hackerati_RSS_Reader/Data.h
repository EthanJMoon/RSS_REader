//
//  Data.h
//  hackerati_RSS_Reader
//
//  Created by Ethan on 9/8/14.
//  Copyright (c) 2014 em. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Data : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *smallImageURL;
@property (nonatomic,strong) NSString *largeImageURL;
@property (nonatomic,strong) UIImage *smallImage;
@property (nonatomic,strong) UIImage *largeImage;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *artist;

-(id)init;

@end
