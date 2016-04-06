//
//  orderViewController.h
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "main2ViewController.h"
#import "recommendViewController.h"
#import "FMDBtool.h"

@interface orderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)main2ViewController *VC;
@end
