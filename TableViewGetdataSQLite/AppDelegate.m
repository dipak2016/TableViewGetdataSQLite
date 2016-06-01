//
//  AppDelegate.m
//  TableViewGetdataSQLite
//
//  Created by Mac on 6/1/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize dbpath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *arr=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *stpath=[arr objectAtIndex:0];
    
    dbpath=[stpath stringByAppendingPathComponent:@"state.tyu"];
    
    NSLog(@"%@",dbpath);
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:dbpath])
    {
        sqlite3 *dbsql;
        
        NSArray *arrque=[NSArray arrayWithObjects:@"create table state(st_id integer primary key autoincrement,st_nm varchar(150),st_cod varchar(150))", nil];
        
        for (int i=0; i<arrque.count; i++)
        {
            if (sqlite3_open([dbpath UTF8String], &dbsql)==SQLITE_OK)
            {
                sqlite3_stmt *ppStmt;
                
                if (sqlite3_prepare_v2(dbsql, [[arrque objectAtIndex:i]UTF8String ], -1, &ppStmt, nil)==SQLITE_OK)
                {
                    sqlite3_step(ppStmt);
                }
                sqlite3_finalize(ppStmt);
            }
            sqlite3_close(dbsql);
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
