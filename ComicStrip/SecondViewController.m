//
//  SecondViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "SecondViewController.h"
#import "GPUImageSketchFilter.h"
@interface SecondViewController () {
    GPUImageOutput<GPUImageInput> *_filter;
    GPUImageOutput<GPUImageInput> *_clearFilter;
    GPUImageStillCamera *_stillCamera;
}
@property (nonatomic, strong) IBOutlet UIButton *shootButton;
@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Frame", @"Add Frame");
//        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _stillCamera = [[GPUImageStillCamera alloc] init];
    _stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    _filter = [[GPUImageSketchFilter alloc] init];
    [_stillCamera addTarget:_filter];
    GPUImageView *filterView = (GPUImageView *)self.gpuImageView;
    [_filter addTarget:filterView];
    
    _clearFilter = [[GPUImageFilter alloc] init];
    [_stillCamera addTarget:_clearFilter];
    GPUImageView *clearFilterView = (GPUImageView *)self.clearGpuImageView;
    [_clearFilter addTarget:clearFilterView];
    
    [_stillCamera startCameraCapture];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shootButtonPressed:(id)sender {
    self.imagePreview.image = [_filter imageFromCurrentlyProcessedOutput];
    self.clearImagePreview.image = [_clearFilter imageFromCurrentlyProcessedOutput];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
