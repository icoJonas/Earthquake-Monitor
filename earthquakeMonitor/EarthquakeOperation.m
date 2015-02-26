//
//  EarthquakeOperation.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "EarthquakeOperation.h"

@implementation EarthquakeOperation


#pragma mark
#pragma mark  Public Methods


-(void)performOperationWithDelegate:(id<EarthquakeOperationDelegate>)del
{
    delegate = del;
    webServiceDataSource = [[WebServiceDataSource alloc] initWithDelegate:self];
    sqliteDataSource = [[EarthquakeDataSource alloc] init];
    [webServiceDataSource getHistoricLogEarthquakes];
}


#pragma mark
#pragma mark  Private Methods

-(void)updateDatabaseAfterOperation:(id)d
{
    if ([d isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)d;
        NSArray *featuresArray = [dic objectForKey:WS_EARTHQUAKE_FEATURES];
        [sqliteDataSource insertOrUpdateEarthquakes:featuresArray];
        NSDictionary *metadataDic = [dic objectForKey:WS_EARTHQUAKE_METADATA];
        NSString *title = [metadataDic objectForKey:WS_EARTHQUAKE_TITLE];
        [sqliteDataSource insertOrUpdateTitle:title];
    }
}

#pragma mark
#pragma mark  WebServiceDataSourceDelegate Methods

-(void)webServiceCalledFinished:(id)d
{
    [self performSelectorInBackground:@selector(updateDatabaseAfterOperation:) withObject:d];
    [delegate operationFinished];
}

-(void)webServiceCallError:(NSError *)error
{
    [delegate operationFailedWithError:error];
}


@end
