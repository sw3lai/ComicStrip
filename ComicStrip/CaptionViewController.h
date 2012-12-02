//
//  CaptionViewController.h
//  ComicStrip
//
//  Created by David Lai on 2012-12-02.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"
#import "UIPlaceholderTextView.h"

@interface CaptionViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *captionView;
@property (nonatomic, weak) IBOutlet UIImageView *comicThumb;
@property (nonatomic, weak) IBOutlet UIPlaceHolderTextView *captionBox;
@property (nonatomic, weak) IBOutlet UIButton *acceptButton;
@property (nonatomic, weak) IBOutlet UIButton *discardButton;

- (id)initWithModel:(CellModel *)model;

@end
