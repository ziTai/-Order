//
//  myTableViewCell.h
//  点菜吧
//
//  Created by mac on 15-12-8.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *xuhaoLabel;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
@property (retain, nonatomic) IBOutlet UILabel *kindLabel;
@property (retain, nonatomic) IBOutlet UITextField *countTextField;
@property (retain, nonatomic) IBOutlet UITextField *addTextField;

@end
