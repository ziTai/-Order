//
//  myOrderViewController.m
//  点菜吧
//
//  Created by mac on 15-12-8.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "myOrderViewController.h"
#import "FMDBtool.h"
@interface myOrderViewController ()
@end

@implementation myOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _arr = [[NSMutableArray alloc]initWithCapacity:0];
    [_arr setArray:[FMDBtool alreadyOrder]];
    [self showPrice];
    
}
/**
 *  显示总价格方法
 *
 */
-(void)showPrice
{
    int priceNum = 0;
    for (food*f in _arr)
    {
        if ([f.price isEqualToString:@"(null)"]) {
            f.price = @"0";
        }
        priceNum += [f.price intValue] * f.count;
    }
    _priceLabel.textColor = [UIColor yellowColor];
    _priceLabel.font = [UIFont systemFontOfSize:20];
    _priceLabel.text = [NSString stringWithFormat:@"%d",priceNum];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    food *f = [_arr objectAtIndex:indexPath.row];
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"myTableViewCell" owner:nil options:nil];
        cell = [arr objectAtIndex:0];
    }
    cell.xuhaoLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    cell.nameLabel.text = f.name;
    cell.priceLabel.text = f.price;
    cell.kindLabel.text = f.iKind;
    cell.countTextField.text = [NSString stringWithFormat:@"%d",f.count];
    cell.addTextField.text = f.add;
    cell.countTextField.delegate = self;
    cell.addTextField.delegate = self;
    cell.countTextField.tag = (indexPath.row + 1) * 2;
    cell.addTextField.tag = indexPath.row * 2 +1;
    return cell;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  结束编辑时调用
 *
 *  @param textField 哪个文本框
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    food *f = nil;
    if (textField.tag % 2 == 0) {
        f = [_arr objectAtIndex:textField.tag / 2 - 1];
        f.count = [textField.text intValue];
        NSLog(@"%@",f.add);
    }
    else
    {
        f = [_arr objectAtIndex:(textField.tag - 1) / 2];
        f.add = textField.text;
    }
    [FMDBtool upDataMyOrder:f];
    [self showPrice];

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        food *f = [_arr objectAtIndex:indexPath.row];
        NSLog(@"删除名字为%@的",f.name);
        [FMDBtool DeleteMyOrder:f.name];
        [_arr removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView reloadData];
        [self showPrice];
    }
}
- (void)dealloc {
    [_tableView release];
    [_arr release];
    [_priceLabel release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
