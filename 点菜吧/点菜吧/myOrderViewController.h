//
//  myOrderViewController.h
//  点菜吧
//
//  Created by mac on 15-12-8.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "food.h"
#import "myTableViewCell.h"
@interface myOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITableView *_tableView;
    IBOutlet UILabel *_priceLabel;
}
@property(nonatomic,retain)NSMutableArray *arr;
@end
