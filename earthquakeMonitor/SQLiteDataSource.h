//
//  SQLiteDataSource.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "DatabaseConstants.h"

@interface SQLiteDataSource : NSObject
{
    NSString *dbPath;
    NSDateFormatter *insertDateTimeFormatter;
}

-(id)executeQuery:(NSString *)query;
-(id)executeSingleSelect:(NSString *)tableName andColumnNames:(NSArray *)columnNames andFilter:(NSDictionary *)filterData andLimit:(int)limit;
-(BOOL)executeInsertOperation:(NSString *)tableName andData:(NSDictionary *)insertData;
-(BOOL)executeUpdateOperation:(NSString *)tableName andData:(NSDictionary *)updateData andFilter:(NSDictionary *)filterData;
-(BOOL)executeDeleteOperation:(NSString *)tableName andFilter:(NSDictionary *)filter;


@end
