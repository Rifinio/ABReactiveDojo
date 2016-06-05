//
//  NSDate+Additions.m
//  ABReactiveDojo
//
//  Created by Adil BOUGAMZA on 05/06/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)


- (NSString *) seconds
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss"];

    return [dateFormatter stringFromDate:self];
}

@end
