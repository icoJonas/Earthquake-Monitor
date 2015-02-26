//
//  WebServiceDataSource.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceDataSource.h"

@implementation WebServiceDataSource

#pragma mark
#pragma mark  Initialization Methods

-(id)initWithDelegate:(id <WebServiceDataSourceDelegate>)del
{
    self = [super init];
    if(self)
    {
        delegate = del;
    }
    return self;
}

#pragma mark
#pragma mark  Public Methods

-(void)getHistoricLogEarthquakes {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:WEB_URL]];
    request.timeoutInterval = 720;
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if (error==nil&&data&&[httpResponse statusCode]==200) {
             NSString *stringData=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",stringData);
             NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             [delegate webServiceCalledFinished:jsonDictionary];
         } else {
             [delegate webServiceCallError:error];
         }
     }];
}

@end