//
//  CellModel.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "CellModel.h"
#import "Constants.h"

@implementation CellModel
@synthesize comicImage = comicImage_;
@synthesize realImage = realImage_;
@synthesize dateCreated = dateCreated_;
@synthesize caption = caption_;

- (id)initWithParameters:(NSDictionary *)parameters {
    self = [super init];
    if (self) {
        comicImage_ = [parameters objectForKey:kComicImage];
        realImage_ = [parameters objectForKey:kRealImage];
        caption_ = [[parameters objectForKey:kCaption] uppercaseString];
        dateCreated_ = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
