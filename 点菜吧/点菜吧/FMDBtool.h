//
//  FMDBtool.h
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "food.h"
FMDatabase *_db;
@interface FMDBtool : NSObject
+(BOOL)openDataBase;
+(NSArray*)searchGroupTable;
+(NSArray*)searchDetailTable:(int)group;
+(NSString*)searchQuTou:(int)group;
+(NSArray*)searchRowNum:(int)group name:(NSString *)title;
+(void)addFood:(food*)f;
+(NSArray*)alreadyOrder;
+(void)upDataMyOrder:(food *)f;
+(void)DeleteMyOrder:(NSString *)str;
@end
