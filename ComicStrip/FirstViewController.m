//
//  FirstViewController.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "FirstViewController.h"
#import "ComicStripCell.h"
#import "CellModel.h"
#import "Constants.h"
#import "SecondViewController.h"
#import "AppDelegate.h"
@interface FirstViewController () {
    UIViewController *_viewController2;
    NSMutableArray *cellsArray_;
}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        _viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    cellsArray_ = [[NSMutableArray alloc] initWithArray:appDelegate.cellsArray];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.cellTableView.showsVerticalScrollIndicator = NO;
    self.cellTableView.showsHorizontalScrollIndicator = NO;
    self.cellTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    self.cellTableView.frame = CGRectMake(0, 20, 320, 388);
    
    self.cellTableView.rowHeight = 388;
    
    self.cellTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.cellTableView.separatorColor = [UIColor clearColor];
}

- (IBAction)cameraInvoked:(id)sender {
    [self presentViewController:_viewController2 animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [cellsArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComicStripCell *cell = [tableView dequeueReusableCellWithIdentifier:kComicStripCellXibId];
    if ([cellsArray_ count] > 0) {
        CellModel *cellModel = [cellsArray_ objectAtIndex:[indexPath row]];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kComicStripCellXibId owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        cell.cellModel = cellModel;
        [cell setupCell];
        return cell;
    }
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //Adding objects
    if ([keyPath isEqualToString:kCellsArray] && [[change objectForKey:NSKeyValueChangeNewKey] count] > 0) {
        [cellsArray_ insertObjects:[change objectForKey:NSKeyValueChangeNewKey] atIndexes:[change objectForKey:kIndexes]];
        NSMutableArray *indexPathArrayForInsertion = [[NSMutableArray alloc] init];
        NSIndexPath *indexPathForInsertion = [NSIndexPath indexPathForRow:0 inSection:0];
        [indexPathArrayForInsertion addObject:indexPathForInsertion];

        [self.cellTableView beginUpdates];
        if ([[self cellTableView] numberOfRowsInSection:0] > 0) {
            [self.cellTableView scrollToRowAtIndexPath:indexPathForInsertion atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        [self.cellTableView insertRowsAtIndexPaths:indexPathArrayForInsertion withRowAnimation:UITableViewRowAnimationTop];
        [self.cellTableView endUpdates];
    }
    //Removing objects
    if ([keyPath isEqualToString:kCellsArray] && [[change objectForKey:NSKeyValueChangeOldKey] count] > 0) {
        [cellsArray_ removeObjectsAtIndexes:[change objectForKey:kIndexes]];
    }
    
//    [self.cellTableView reloadData];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
