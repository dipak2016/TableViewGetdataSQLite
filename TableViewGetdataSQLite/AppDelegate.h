//
//  AppDelegate.h
//  TableViewGetdataSQLite
//
//  Created by Mac on 6/1/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain,nonatomic)NSString *dbpath;
@end

