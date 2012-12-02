//
//  ComicStripCell.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "ComicStripCell.h"

@implementation ComicStripCell
@synthesize cellModel = cellModel_;
@synthesize comicImageView = comicImageView_;
@synthesize realImageView = realImageView_;

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.realImageView.alpha = 0.0f;
}

@end
