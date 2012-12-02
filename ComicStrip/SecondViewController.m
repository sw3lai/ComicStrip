//
//  SecondViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "SecondViewController.h"
#import "GPUImageSketchFilter.h"
#import "CaptionViewController.h"
#import "Constants.h"

@interface SecondViewController () {
    GPUImageOutput<GPUImageInput> *_filter;
    GPUImageOutput<GPUImageInput> *_clearFilter;
    GPUImageStillCamera *_stillCamera;
    UIViewController *_captionViewController;
}
@property (nonatomic, strong) IBOutlet UIButton *shootButton;
@property (nonatomic, strong) IBOutlet UIButton *acceptButton;
@property (nonatomic, strong) IBOutlet UIButton *rejectButton;
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
    [self showShootButton];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shootButtonPressed:(id)sender {
    [self showAcceptRejectButtons];
    
    self.imagePreview.image = [_filter imageFromCurrentlyProcessedOutput];
    self.clearImagePreview.image = [_clearFilter imageFromCurrentlyProcessedOutput];
}

- (IBAction)acceptButtonPressed:(id)sender {
    NSDictionary *modelParams = [[NSMutableDictionary alloc] init];
    [modelParams setValue:self.imagePreview.image forKey:kComicImage];
    [modelParams setValue:self.clearImagePreview.image forKey:kRealImage];
    
    CellModel *model = [[CellModel alloc] initWithParameters:modelParams];
    _captionViewController = [[CaptionViewController alloc] initWithModel:model];
    
    [self presentViewController:_captionViewController animated:YES completion:^{
    }];
    
    [self showShootButton];
}

- (IBAction)rejectButtonPressed:(id)sender {
    [self showShootButton];
}

- (void)showShootButton {
    self.shootButton.hidden = NO;
    self.acceptButton.hidden = YES;
    self.rejectButton.hidden = YES;
}

- (void)showAcceptRejectButtons {
    self.shootButton.hidden = YES;
    self.acceptButton.hidden = NO;
    self.rejectButton.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
