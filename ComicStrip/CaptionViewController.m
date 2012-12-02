//
//  CaptionViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-02.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "CaptionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "AppDelegate.h"

@implementation CaptionViewController {
    CellModel *cellModel_;
    UIViewController *previousViewController_;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.captionView.layer setCornerRadius:10.0f];
    [self.captionView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.captionView.layer setBorderWidth:3.0f];
    [self.captionView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.captionView.layer setShadowOpacity:0.8];
    [self.captionView.layer setShadowRadius:3.0];
    [self.captionView.layer setShadowOffset:CGSizeMake(3.0, 3.0)];
    self.comicThumb.image = cellModel_.comicImage;
    self.captionBox.placeholder = kWriteComicDialog;
    [self.captionBox becomeFirstResponder];
}

- (id)initWithModel:(CellModel *)model {
    self = [super initWithNibName:@"CaptionViewController" bundle:nil];
    
    if (self) {
        cellModel_ = model;
    }
    return self;
}

- (void)setPreviousView:(UIViewController *)prevView {
    previousViewController_ = prevView;
}

- (IBAction)acceptButtonPressed:(id)sender {
    cellModel_.caption = self.captionBox.text;

    [self.view removeFromSuperview];
    
    [previousViewController_ dismissViewControllerAnimated:YES completion:^{
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [[appDelegate mutableArrayValueForKey:kCellsArray] insertObject:cellModel_ atIndex:0];
    }];
}

- (IBAction)discardButtonPressed:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView * fromView = [self view];
        UIView * toView = [previousViewController_ view];
        
        // Get the size of the view area.
        CGRect viewSize = fromView.frame;
        BOOL scrollLeft = YES;
        
        // Position it off screen.
        toView.frame = CGRectMake((scrollLeft ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
        
        [UIView
         animateWithDuration:0.4
         animations: ^{
             // Animate the views on and off the screen. This will appear to slide.
             fromView.frame =CGRectMake((scrollLeft ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
             toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
         }
         completion:^(BOOL finished) {
             [self.view removeFromSuperview];
         }];
    });
}

@end
