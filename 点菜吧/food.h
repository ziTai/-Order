//
//  food.h
//  点菜吧
//
//  Created by mac on 15-12-5.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface food : NSObject
@property(nonatomic,assign)int groupID;
@property(nonatomic,copy)NSString *iKind;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *unit;
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,copy)NSString *picName;
@property(nonatomic,assign)int count;
@property(nonatomic,copy)NSString *add;
@end
