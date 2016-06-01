//
//  ViewController.h
//  TableViewGetdataSQLite
//
//  Created by Mac on 6/1/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dboperation.h"
@interface ViewController : UIViewController<NSURLSessionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *dict_mute;
    NSMutableArray *arr_mute;
    Dboperation *dbop;
}
@property (weak, nonatomic) IBOutlet UITableView *tbl_vw;
@end

