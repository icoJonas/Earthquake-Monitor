//
//  EarthquakeDataSource.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "EarthquakeDataSource.h"
#import "WebServiceConstants.h"

@implementation EarthquakeDataSource

-(NSArray *)getLastEarthquakes {
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT * FROM %@ ORDER BY %@ DESC",DB_EARTHQUAKE_TABLE, DB_EARTHQUAKE_TIME];
    NSArray *array = [self executeQuery:query];
    return array;
}

-(void)insertOrUpdateEarthquakes:(NSArray *)features {
    for (NSDictionary *dic in features) {
        NSString *ID = [dic objectForKey:WS_EARTHQUAKE_ID_KEY];
        NSString *selectQuery = [[NSString alloc] initWithFormat:@"SELECT %@ FROM %@ WHERE %@ = '%@'",DB_EARTHQUAKE_ID_KEY, DB_EARTHQUAKE_TABLE, DB_EARTHQUAKE_ID_KEY, ID];
        NSArray *array = [self executeQuery:selectQuery];
        if (array.count == 0) {
            NSDictionary *propertiesDic = [dic objectForKey:WS_EARTHQUAKE_PROPERTIES];
            
            float magnitude = [[propertiesDic objectForKey:WS_EARTHQUAKE_MAGNITUDE] floatValue];
            double time = [[propertiesDic objectForKey:WS_EARTHQUAKE_TIME] doubleValue];
            NSString *place = [propertiesDic objectForKey:WS_EARTHQUAKE_PLACE];
            NSDictionary *geometry = [dic objectForKey:WS_EARTHQUAKE_GEOMETRY];
            NSArray *coordinates = [geometry objectForKey:WS_EARTHQUAKE_COORDINATES];
            double latitude = [[coordinates objectAtIndex:0] floatValue];
            double longitude = [[coordinates objectAtIndex:1] floatValue];
            float depth = [[coordinates objectAtIndex:2] floatValue];
            
            NSMutableDictionary *dicToInsert = [[NSMutableDictionary alloc] init];
            [dicToInsert setValue:ID forKey:DB_EARTHQUAKE_ID_KEY];
            [dicToInsert setValue:place forKey:DB_EARTHQUAKE_PLACE];
            [dicToInsert setValue:[NSNumber numberWithDouble:latitude] forKey:DB_EARTHQUAKE_LATITUDE];
            [dicToInsert setValue:[NSNumber numberWithDouble:longitude] forKey:DB_EARTHQUAKE_LONGITUDE];
            [dicToInsert setValue:[NSNumber numberWithFloat:depth] forKey:DB_EARTHQUAKE_DEPTH];
            [dicToInsert setValue:[NSNumber numberWithFloat:magnitude] forKey:DB_EARTHQUAKE_MAGNITUDE];
            [dicToInsert setValue:[NSNumber numberWithDouble:time] forKey:DB_EARTHQUAKE_TIME];
            
            [self executeInsertOperation:DB_EARTHQUAKE_TABLE andData:dicToInsert];
        }
    }
}

-(void)insertOrUpdateTitle:(NSString *)title {
    NSString *selectQuery = [[NSString alloc] initWithFormat:@"SELECT %@ FROM %@",DB_METADATA_TITLE, DB_METADATA_TABLE];
    NSArray *array = [self executeQuery:selectQuery];
    if (array.count == 0) {
        [self executeInsertOperation:DB_METADATA_TABLE andData:[NSDictionary dictionaryWithObject:title forKey:DB_METADATA_TITLE]];
    } else {
        [self executeUpdateOperation:DB_METADATA_TABLE andData:[NSDictionary dictionaryWithObject:title forKey:DB_METADATA_TITLE] andFilter:[NSDictionary dictionaryWithObject:[[array objectAtIndex:0] objectForKey:DB_METADATA_TITLE] forKey:DB_METADATA_TITLE]];
    }
}

-(NSString *)getTitle {
    NSString *selectQuery = [[NSString alloc] initWithFormat:@"SELECT %@ FROM %@",DB_METADATA_TITLE, DB_METADATA_TABLE];
    NSArray *array = [self executeQuery:selectQuery];
    return [[array objectAtIndex:0] objectForKey:DB_METADATA_TITLE];
}

@end