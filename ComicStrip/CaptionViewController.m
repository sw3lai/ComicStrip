//
//  CaptionViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-02.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "CaptionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation CaptionViewController
@synthesize captionView = captionView_;
@synthesize captionBox = captionBox_;
@synthesize acceptButton = acceptButton_;
@synthesize discardButton = discardButton_;
@synthesize comicThumb = comicThumb_;

- (void) customInit {
    [captionView_.layer setCornerRadius:30.0f];
    [captionView_.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [captionView_.layer setBorderWidth:1.5f];
    [captionView_.layer setShadowColor:[UIColor blackColor].CGColor];
    [captionView_.layer setShadowOpacity:0.8];
    [captionView_.layer setShadowRadius:3.0];
    [captionView_.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (IBAction)acceptButtonPressed:(id)sender {

}

- (IBAction)discardButtonPressed:(id)sender {

}

@end
