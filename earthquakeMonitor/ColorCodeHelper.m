//
//  ColorCodeHelper.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "ColorCodeHelper.h"

@implementation ColorCodeHelper

#pragma mark
#pragma mark  Public Methods

+(UIColor *)colorForMagnitude:(float)magnitude {
    
    CGFloat scale = magnitude/10;
    CGFloat red = 255 * scale;
    CGFloat green = 255 - (red);
    
    return [UIColor colorWithRed:red/255.00 green:green/255.00 blue:0.0 alpha:1.0];
}

@end