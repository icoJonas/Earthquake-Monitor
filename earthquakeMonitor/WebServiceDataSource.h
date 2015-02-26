//
//  WebServiceDataSource.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceConstants.h"


@protocol WebServiceDataSourceDelegate <NSURLConnectionDelegate>

-(void)webServiceCalledFinished:(id)data;
-(void)webServiceCallError:(NSError *)error;

@end

@interface WebServiceDataSource : NSObject
{
    
    id<WebServiceDataSourceDelegate> delegate;
}

-(id)initWithDelegate:(id <WebServiceDataSourceDelegate>)del;

-(void)getHistoricLogEarthquakes;

@end
