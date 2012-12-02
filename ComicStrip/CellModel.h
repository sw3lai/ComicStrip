//
//  CellModel.h
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject {
    UIImage *comicImage_;
    UIImage *realImage_;
}

@property (nonatomic, strong) UIImage *comicImage;
@property (nonatomic, strong) UIImage *realImage;

@end