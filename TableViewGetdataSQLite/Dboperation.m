//
//  Dboperation.m
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "Dboperation.h"


@implementation Dboperation
@synthesize get_dbpath;
-(id)init
{
    if (self=[super init])
    {
        AppDelegate *deli=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        get_dbpath=deli.dbpath;
    }
    return self;
}
-(void)Insertbulkdata:(NSArray *)arr
{
    sqlite3 *dbsql;
    for (int i=0; i<arr.count; i++)
    {
        if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
        {
            sqlite3_stmt *ppStmt;
            
            NSString *query=[NSString stringWithFormat:@"insert into state(st_nm,st_cod)values('%@','%@')",[[arr objectAtIndex:i]objectForKey:@"title"],[[arr objectAtIndex:i]objectForKey:@"img"]];
            
            if (sqlite3_prepare_v2(dbsql, [query UTF8String ], -1, &ppStmt, nil)==SQLITE_OK)
            {
                sqlite3_step(ppStmt);
            }
            sqlite3_finalize(ppStmt);
        }
        sqlite3_close(dbsql);
    }
}
-(void)deletebulkdata
{
    sqlite3 *dbsql;
    if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        
        NSString *query=[NSString stringWithFormat:@"delete from state where 1=1"];
        
        if (sqlite3_prepare_v2(dbsql, [query UTF8String ], -1, &ppStmt, nil)==SQLITE_OK)
        {
            sqlite3_step(ppStmt);
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
}
-(NSMutableArray *)SelectAllData:(NSString *)query
{
    sqlite3 *dbsql;
    NSMutableArray *arr_mute=[[NSMutableArray alloc]init];
    NSMutableDictionary *dict_mute=[[NSMutableDictionary alloc]init];
    
    if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        
        if (sqlite3_prepare_v2(dbsql, [query UTF8String ], -1, &ppStmt, nil)==SQLITE_OK)
        {
            while (sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                
                NSString *stid=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 0)];
                NSString *stnm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 1)];
                NSString *stcod=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 2)];
                
                [dict_mute setObject:stid forKey:@"st_id"];
                [dict_mute setObject:stnm forKey:@"stnm"];
                [dict_mute setObject:stcod forKey:@"stcod"];
                
                [arr_mute addObject:[dict_mute copy]];
                
            };
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return arr_mute;
}
@end
