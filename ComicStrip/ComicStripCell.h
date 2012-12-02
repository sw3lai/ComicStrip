//
//  ComicStripCell.h
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

@interface ComicStripCell : UITableViewCell {
    CellModel *cellModel_;
    
}

@property (nonatomic, strong) CellModel *cellModel;
@property (nonatomic, assign) IBOutlet UIImageView *comicImageView;
@property (nonatomic, assign) IBOutlet UIImageView *realImageView;

- (void)setupCell;

@end
