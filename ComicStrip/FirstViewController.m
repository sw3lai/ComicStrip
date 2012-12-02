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
    UIButton *startButton = [[UIButton alloc] init];
    startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.tag = 1;
    startButton.frame = CGRectMake(0, 0, 64, 45);
    [startButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabBar-camera" ofType:@"png"]] forState:UIControlStateNormal];
    startButton.adjustsImageWhenHighlighted = NO;
    [startButton addTarget:self action:@selector(cameraInvoked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cellTableView setTableHeaderView:startButton];
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
    }
    //Removing objects
    if ([keyPath isEqualToString:kCellsArray] && [[change objectForKey:NSKeyValueChangeOldKey] count] > 0) {
        [cellsArray_ removeObjectsAtIndexes:[change objectForKey:kIndexes]];
    }
    
    [self.cellTableView reloadData];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 388;
}

@end
