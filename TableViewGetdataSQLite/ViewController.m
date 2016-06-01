//
//  ViewController.m
//  TableViewGetdataSQLite
//
//  Created by Mac on 6/1/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tbl_vw;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dbop=[[Dboperation alloc]init];
    
    tbl_vw.dataSource=self;
    tbl_vw.delegate=self;
    dict_mute=[[NSMutableDictionary alloc]init];
    arr_mute=[[NSMutableArray alloc]init];
    
    //With out paramter
    /*
     NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/squarefrog/TraktTopTen/master/TraktTopTenTests/Network%20Stubs/popular-movies.json"];
     
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
     
     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
     
     NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     
     if (error != nil) {
     
     NSLog(@"%@", [error localizedDescription]);
     }
     else{
     
     NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
     
     
     if (HTTPStatusCode != 200) {
     NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
     }
     
     
     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
     
     if (data != nil) {
     NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     for (int i=0; i<arr.count; i++)
     {
     NSDictionary *dict=[arr objectAtIndex:i];
     
     [dict_mute setObject:[[[dict objectForKey:@"images"]objectForKey:@"logo"]objectForKey:@"full"] forKey:@"img"];
     
     [dict_mute setObject:[dict objectForKey:@"title"] forKey:@"title"];
     
     [arr_mute addObject:[dict_mute copy]];
     
     }
     [tbl_vw reloadData];
     }
     
     }];
     }
     }];
     
     // Resume the task.
     [task resume];
     */
    
    //POST paramter
    
    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/squarefrog/TraktTopTen/master/TraktTopTenTests/Network%20Stubs/popular-movies.json"];
    
    //NSString *st_body=[NSString stringWithFormat:@"para=%@&para2=%@",@"ashok",@"arjkot"];
    
    NSMutableURLRequest *req=[[NSMutableURLRequest alloc]initWithURL:url];
    //[req setHTTPBody:[st_body dataUsingEncoding:NSUTF8StringEncoding]];
    [req setHTTPMethod:@"POST"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (error != nil) {
                                          
                                          NSLog(@"%@", [error localizedDescription]);
                                      }
                                      else{
                                          
                                          NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                          
                                          
                                          if (HTTPStatusCode != 200) {
                                              NSLog(@"HTTP status code = %ld", (long)HTTPStatusCode);
                                          }
                                          
                                          
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                              
                                              if (data != nil)
                                              {
                                                  NSArray *arr=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                  for (int i=0; i<arr.count; i++)
                                                  {
                                                      NSDictionary *dict=[arr objectAtIndex:i];
                                                      
                                                      [dict_mute setObject:[[[dict objectForKey:@"images"]objectForKey:@"logo"]objectForKey:@"full"] forKey:@"img"];
                                                      
                                                      [dict_mute setObject:[dict objectForKey:@"title"] forKey:@"title"];
                                                      
                                                      [arr_mute addObject:[dict_mute copy]];
                                                      
                                                  }
                                                  [dbop deletebulkdata];
                                                  [dbop Insertbulkdata:arr_mute];
                                                  [arr_mute removeAllObjects];
                                                  arr_mute=[dbop SelectAllData:@"select * from state"];
                                                  [tbl_vw reloadData];
                                              }
                                          }];
                                      }
                                      
                                  }];
    // Resume the task.
    [task resume];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_mute.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text=[[arr_mute objectAtIndex:indexPath.row]objectForKey:@"stnm"];
    
    NSURL *url=[NSURL URLWithString:[[arr_mute objectAtIndex:indexPath.row]objectForKey:@"stcod"]];
    
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    cell.imageView.image=[UIImage imageWithData:data];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
