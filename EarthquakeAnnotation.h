//
//  EarthquakeAnnotation.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

@interface EarthquakeAnnotation : NSObject <MKAnnotation> {
    NSString *_place;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *place;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithPlace:(NSString*)place coordinate:(CLLocationCoordinate2D)coordinate;

@end

