//
//  EarthquakeOperation.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceDataSource.h"
#import "EarthquakeDataSource.h"

@protocol EarthquakeOperationDelegate <NSObject>

-(void)operationFinished;
-(void)operationFailedWithError:(NSError *)error;

@end

@interface EarthquakeOperation : NSObject <WebServiceDataSourceDelegate>
{
    id<EarthquakeOperationDelegate> delegate;
    WebServiceDataSource *webServiceDataSource;
    EarthquakeDataSource *sqliteDataSource;
}

-(void)performOperationWithDelegate:(id<EarthquakeOperationDelegate>)del
;
@end
