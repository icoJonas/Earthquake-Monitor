//
//  EarthquakeAnnotation.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "EarthquakeAnnotation.h"

@implementation EarthquakeAnnotation
@synthesize place = _place;
@synthesize coordinate = _coordinate;

- (id)initWithPlace:(NSString *)place coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _place = [place copy];
        _coordinate = coordinate;
    }
    return self;
}



@end