//
//  FMDBtool.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "FMDBtool.h"
@implementation FMDBtool
+(BOOL)openDataBase
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    _db = [[FMDatabase alloc]initWithPath:path];
    if ([_db open])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//查找groupTabl图片名字
+(NSArray*)searchGroupTable
{
    [self openDataBase];
    NSString *sql = @"SELECT *FROM groupTable";
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *picArray = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *highArr = [NSMutableArray array];
    while ([set next])
    {
        NSString *str = [set stringForColumnIndex:3];
        NSString *highStr = [set stringForColumnIndex:4];
        [arr addObject:str];
        [highArr addObject:highStr];
    }
    [picArray addObject:arr];
    [picArray addObject:highArr];
    [set close];
    [_db close];
    return picArray;
}
//查找对应的区头
+(NSString*)searchQuTou:(int)group
{
    [self openDataBase];
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM groupTable WHERE id=%d",group + 1];
    FMResultSet *set = [_db executeQuery:sql];
    NSString *str = @"";
    while ([set next])
    {
        NSString *name = [set stringForColumnIndex:2];
        str = name;
    }
    [set close];
    [_db close];
    return str;
}



//查找详细的菜的内容
+(NSArray*)searchDetailTable:(int)group
{
    [self openDataBase];
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM menuTable WHERE groupID=%d",group + 1];
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *foodArray = [NSMutableArray array];
    while ([set next])
    {
        food *f = [[food alloc]init];
        f.name = [set stringForColumnIndex:3];
        f.picName = [set stringForColumnIndex:7];
        [foodArray addObject:f];
        [f release];
    }
    [set close];
    [_db close];
    return foodArray;
}
//查询每个区具体内容
+(NSArray*)searchRowNum:(int)group name:(NSString *)title
{
    [self openDataBase];
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM menuTable WHERE groupID=%d AND iKind='%@'",group + 1,title];
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *foodArr = [NSMutableArray array];
    while ([set next])
    {
        food *f = [[food alloc]init];
        f.name = [set stringForColumnIndex:3];
        f.price = [set stringForColumnIndex:4];
        f.unit = [set stringForColumnIndex:5];
        f.detail = [set stringForColumnIndex:6];
        f.picName = [set stringForColumnIndex:7];
        f.iKind = [set stringForColumnIndex:2];
        [foodArr addObject:f];
        [f release];

    }
    [set close];
    [_db close];
    return foodArr;
}
//添加food类
+(void)addFood:(food*)f
{
    if ([self openDataBase])
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT *FROM orderTable WHERE menuName='%@'",f.name];
        FMResultSet *set = [_db executeQuery:sql];
        if ([set next])
        {
            //份数＋1
            int num = [set intForColumnIndex:4];
            NSString *sql1 = [NSString stringWithFormat:@"UPDATE orderTable set menuNum=%d WHERE menuName='%@'",num + 1,f.name];
            [_db executeUpdate:sql1];
    
        }
        else
        {
            //插入数据
            NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO orderTable (menuName,Price,kind,menuNum,remark)VALUES('%@','%@','%@',1,'无')",f.name,f.price,f.iKind];
            [_db executeUpdate:sql1];
        }
        [set close];
    }
    [_db close];
  
}
//读取已点菜单
+(NSArray*)alreadyOrder
{
    if ([self openDataBase])
    {
        NSString *sql = @"SELECT *FROM orderTable";
        FMResultSet *set = [_db executeQuery:sql];
        NSMutableArray *arr = [NSMutableArray array];
        while ([set next])
        {
            food *f = [[food alloc]init];
            f.name = [set stringForColumnIndex:1];
            f.price = [set stringForColumnIndex:2];
            f.iKind = [set stringForColumnIndex:3];
            f.count = [set intForColumnIndex:4];
            f.add = [set stringForColumnIndex:5];
            [arr addObject:f];
            [f release];
        }
        [set close];
        [_db close];
        return arr;
    }
    return nil;
}
/**
 *  修改我的点单
 */
+(void)upDataMyOrder:(food *)f
{
    if ([self openDataBase])
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT *FROM orderTable WHERE menuName = '%@'",f.name];
        NSLog(@"%@",f.name);
        FMResultSet *set = [_db executeQuery:sql];
        if ([set next])
        {
            [_db executeUpdate:@"UPDATE orderTable SET menuNum =?,remark=? WHERE menuName=?",[NSNumber numberWithInt:f.count],f.add,f.name];
        }
        [set close];
    }
    [_db close];
}
/**
 *  删除我的点单中某一行
 */
+(void)DeleteMyOrder:(NSString *)str
{
    if ([self openDataBase])
    {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM orderTable WHERE menuName ='%@'",str];
        if ([_db executeUpdate:sql])
        {
            NSLog(@"删除成功");
        }
        [_db close];
    }
}
@end
