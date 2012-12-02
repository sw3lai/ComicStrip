//
//  Utils.m
//  ComicStrip
//
//  Created by David Lai on 2012-12-01.
//  Copyright (c) 2012 David Lai. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"
#import <Math.h>

#define SEC_IN_MIN          60
#define SEC_IN_HOUR         3600
#define SEC_IN_DAY          86400
#define SEC_IN_WEEK         604800

@implementation Utils

+ (NSString *)timeRelativeToInterval:(NSTimeInterval)timeInSec {
    NSTimeInterval howMuchTimeHasPast = fabs(timeInSec - [[NSDate date] timeIntervalSince1970]);
    
    if (howMuchTimeHasPast < 1) {
        return kJustNow;
    } else if (howMuchTimeHasPast < SEC_IN_MIN) {
        return [NSString stringWithFormat:@"%.0fs", howMuchTimeHasPast];
    } else if(howMuchTimeHasPast < SEC_IN_HOUR) {
        return [NSString stringWithFormat:@"%.0fm", howMuchTimeHasPast/SEC_IN_MIN];
    } else if(howMuchTimeHasPast < SEC_IN_DAY) {
        return [NSString stringWithFormat:@"%.0fh", howMuchTimeHasPast/SEC_IN_HOUR];
    } else if(howMuchTimeHasPast < SEC_IN_WEEK) {
        return [NSString stringWithFormat:@"%.0fd", howMuchTimeHasPast/SEC_IN_DAY];
    } else {
        return [NSString stringWithFormat:@"%.0fw", howMuchTimeHasPast/SEC_IN_WEEK];
    }
}

@end
