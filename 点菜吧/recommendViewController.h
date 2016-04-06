//
//  recommendViewController.h
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDBtool.h"
@interface recommendViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIScrollView        *_scrollView;
    UITableView         *_tableView;
    NSMutableArray      *_picArr;
    NSMutableArray      *_kindArr;
    NSMutableArray      *_arr;
    int                 _select;
    UIImageView         *_cellLine;

}
@property(nonatomic,assign)int  index;
@property(nonatomic,assign)int  selectRow;
@end
