//
//  Dboperation.h
//  Online&Offline
//
//  Created by Yosemite on 5/13/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Dboperation : NSObject

@property(retain,nonatomic)NSString *get_dbpath;
-(void)Insertbulkdata:(NSArray *)arr;
-(void)deletebulkdata;
-(NSMutableArray *)SelectAllData:(NSString *)query;
@end
