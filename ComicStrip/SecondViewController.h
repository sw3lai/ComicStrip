//
//  SecondViewController.h
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImageStillCamera.h"
#import "GPUImageView.h"
@interface SecondViewController : UIViewController
@property (nonatomic, weak) IBOutlet GPUImageView *gpuImageView;
@property (nonatomic, weak) IBOutlet GPUImageView *clearGpuImageView;
@property (nonatomic, weak) IBOutlet UIImageView *clearImagePreview;
@property (nonatomic, weak) IBOutlet UIImageView *imagePreview;

@end
