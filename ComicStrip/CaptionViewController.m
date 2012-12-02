//
//  CaptionViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-02.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "CaptionViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation CaptionViewController {
    CellModel *cellModel_;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.captionView.layer setCornerRadius:10.0f];
    [self.captionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.captionView.layer setBorderWidth:1.0f];
    [self.captionView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.captionView.layer setShadowOpacity:0.8];
    [self.captionView.layer setShadowRadius:2.0];
    [self.captionView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    self.comicThumb.image = cellModel_.comicImage;
}

- (id)initWithModel:(CellModel *)model {
    self = [super initWithNibName:@"CaptionViewController" bundle:nil];
    
    if (self) {
        cellModel_ = model;
    }
    return self;
}

- (IBAction)acceptButtonPressed:(id)sender {

}

- (IBAction)discardButtonPressed:(id)sender {

}

@end
