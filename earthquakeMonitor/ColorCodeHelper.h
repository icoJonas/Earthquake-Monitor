//
//  ColorCodeHelper.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorCodeHelper : NSObject

+(UIColor *)colorForMagnitude:(float)magnitude;

@end