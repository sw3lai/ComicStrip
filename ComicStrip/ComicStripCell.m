//
//  ComicStripCell.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "ComicStripCell.h"
#import "Constants.h"

@implementation ComicStripCell
@synthesize cellModel = cellModel_;
@synthesize comicImageView = comicImageView_;
@synthesize realImageView = realImageView_;

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.realImageView.alpha = 0.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    [super touchesBegan:touches withEvent:event];
    if (self.realImageView.image == nil) {
        return;
    } else {
        [UIView animateWithDuration:kFadeDelay animations:^{
            self.realImageView.alpha = 1.0f;
        }];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    [super touchesEnded:touches withEvent:event];
    if (self.realImageView.image == nil) {
        return;
    } else {
        [UIView animateWithDuration:kFadeDelay animations:^{
            self.realImageView.alpha = 0.0f;
        }];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesCancelled");
    [super touchesCancelled:touches withEvent:event];
    if (self.realImageView.image == nil) {
        return;
    } else {
        [UIView animateWithDuration:kFadeDelay animations:^{
            self.realImageView.alpha = 0.0f;
        }];
    }
}

@end
