//
//  ComicStripCell.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "ComicStripCell.h"
#import "Constants.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComicStripCell
@synthesize cellModel = cellModel_;
@synthesize comicImageView = comicImageView_;
@synthesize realImageView = realImageView_;
@synthesize captionLabel = captionLabel_;
@synthesize dateLabel = dateLabel_;
@synthesize frameView = frameView_;

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cellModel_) {
        comicImageView_.image = cellModel_.comicImage;
        realImageView_.image = cellModel_.realImage;
        captionLabel_.text = [cellModel_.caption uppercaseString];
        dateLabel_.text = [Utils timeRelativeToInterval:cellModel_.dateCreated];
    }
    
    [frameView_.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [frameView_.layer setBorderWidth: 3.0];
    
    self.realImageView.alpha = 0.0f;
    self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);

    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    
    longPressGesture.minimumPressDuration = 0.1;
    [self.frameView addGestureRecognizer:longPressGesture];
}

-(void) longPressDetected:(UILongPressGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        if (self.realImageView.image == nil) {
            return;
        } else {
            [UIView animateWithDuration:kFadeDelay animations:^{
                self.realImageView.alpha = 1.0f;
            }];
        }
    }

    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        if (self.realImageView.image == nil) {
            return;
        } else {
            [UIView animateWithDuration:kFadeDelay animations:^{
                self.realImageView.alpha = 0.0f;
            }];
        }
    }
}

@end
