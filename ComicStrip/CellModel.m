//
//  CellModel.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel
@synthesize comicImage = comicImage_;
@synthesize realImage = realImage_;
@synthesize dateCreated = dateCreated_;

- (id)initWithComicImage:(UIImage *)comicImg andRealImage:(UIImage *)realImg {
    self = [super init];
    if (self) {
        comicImage_ = comicImg;
        realImage_ = realImg;
        dateCreated_ = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
