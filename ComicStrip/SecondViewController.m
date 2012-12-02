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
    self.imagePreview.image = [_filter imageFromCurrentlyProcessedOutput];
    self.clearImagePreview.image = [_clearFilter imageFromCurrentlyProcessedOutput];
    [self showAcceptRejectButtons];
}

- (IBAction)acceptButtonPressed:(id)sender {
    
    NSDictionary *modelParams = [[NSMutableDictionary alloc] init];
    [modelParams setValue:self.imagePreview.image forKey:kComicImage];
    [modelParams setValue:self.clearImagePreview.image forKey:kRealImage];
    
    CellModel *model = [[CellModel alloc] initWithParameters:modelParams];
    
    [self showShootButton];
    CaptionViewController *captionViewController = [[CaptionViewController alloc] initWithModel:model];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView * fromView = [self view];
        UIView * toView = [captionViewController view];
        
        // Get the size of the view area.
        CGRect viewSize = fromView.frame;
        BOOL scrollRight = YES;
        
        // Add the to view to the tab bar view.
        [fromView.superview addSubview:toView];
        
        // Position it off screen.
        toView.frame = CGRectMake((scrollRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
        
        [UIView
         animateWithDuration:0.4
         animations: ^{
             // Animate the views on and off the screen. This will appear to slide.
             fromView.frame =CGRectMake((scrollRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
             toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
         }
         completion:^(BOOL finished) {
         }];
    });
    
}

- (IBAction)rejectButtonPressed:(id)sender {
    [self showShootButton];
}

- (void)showShootButton {
    self.shootButton.hidden = NO;
    self.acceptButton.hidden = YES;
    self.rejectButton.hidden = YES;
    self.imagePreview.hidden = YES;
}

- (void)showAcceptRejectButtons {
    self.shootButton.hidden = YES;
    self.acceptButton.hidden = NO;
    self.rejectButton.hidden = NO;
    self.imagePreview.hidden = NO;
}

- (IBAction)cancelAddFrame:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
