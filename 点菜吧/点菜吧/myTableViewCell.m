//
//  myTableViewCell.m
//  点菜吧
//
//  Created by mac on 15-12-8.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell

- (void)awakeFromNib
{
    _countTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {


    [_xuhaoLabel release];
    [_nameLabel release];
    [_priceLabel release];
    [_kindLabel release];
    [_countTextField release];
    [_addTextField release];
    [super dealloc];
}
@end
