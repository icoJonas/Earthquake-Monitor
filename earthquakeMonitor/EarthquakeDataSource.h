//
//  EarthquakeDataSource.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "SQLiteDataSource.h"

@interface EarthquakeDataSource : SQLiteDataSource

-(NSArray *)getLastEarthquakes;
-(void)insertOrUpdateEarthquakes:(NSArray *)features;
-(void)insertOrUpdateTitle:(NSString *)title;
-(NSString *)getTitle;

@end
