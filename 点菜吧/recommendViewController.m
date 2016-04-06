//
//  recommendViewController.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "recommendViewController.h"
#import "food.h"
#import "detailViewController.h"
#import "myOrderViewController.h"
@interface recommendViewController ()

@end

@implementation recommendViewController

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
    for (UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    _picArr = [[NSMutableArray alloc]initWithCapacity:0];
    _kindArr = [[NSMutableArray alloc]initWithCapacity:0];
    _arr = [[NSMutableArray alloc]initWithCapacity:0];
    [_picArr setArray:[FMDBtool searchDetailTable:self.index]];
    NSString *str = [FMDBtool searchQuTou:self.index];
    [_kindArr setArray: [str componentsSeparatedByString:@"|"]];
    

    //将子视图转为横屏
    //注意这个地方的起始坐标并不是看到的  而是屏幕竖直时的左上角坐标
    self.view.frame = CGRectMake(0, 0, 1024, 1024);
    
    //设置背景图片
    if (self.index == 0)
    {
        UIImageView *bgImg = [[UIImageView alloc]init];
        bgImg.image = [UIImage imageNamed:@"bgp3.png"];
        bgImg.frame = CGRectMake(0, 0, 1024, 768);
        UIImageView *bgImg1 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"bgp31.png"]];
        bgImg1.frame = CGRectMake(0, 0, 1024, 768);
        UIImageView *bgImg2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgp33.png"]];
        bgImg2.frame = CGRectMake(665, 40, 300, 700);
        [self.view addSubview:bgImg];
        [self.view addSubview:bgImg1];
        [self.view addSubview:bgImg2];
        [self.view bringSubviewToFront:bgImg2];
        
        [bgImg release];
        [bgImg1 release];
        [bgImg2 release];
        
    }
    else
    {
        UIImageView *bgImg = [[UIImageView alloc]init];
        bgImg.image = [UIImage imageNamed:@"bgp4.png"];
        bgImg.frame = CGRectMake(0, 0, 1024, 768);
        [self.view addSubview:bgImg];
        
        [bgImg release];
    }
    //创建图片label
    UIImageView *labelImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%dicon.png",self.index + 1]]];
    labelImg.frame = CGRectMake(20, 20, 280, 120);
    [self.view addSubview:labelImg];

    //设置scrollview的背景图片
    UIImageView *scrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgp41.png"]];
    if (self.index != 0)
    {
        scrImg.frame = CGRectMake(330, 100, 600, 570);
    }
    else
    {
        scrImg.frame = CGRectZero;
    }
    [self.view addSubview:scrImg];
    
    //设置scrollview
    _scrollView = [[UIScrollView alloc] init];
    if (self.index == 0)
    {
        _scrollView.frame = CGRectMake(0, 10, 1024, 748);
    }
    else
    {
        _scrollView.frame = CGRectMake(340, 120, 490, 520);
    }
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self scrollImg];
    [self.view addSubview:_scrollView];
    
    
    //创建tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self.index == 0)
    {
        _tableView.frame = CGRectMake(667, 150, 300, 500);
    }
    else
    {
        _tableView.frame = CGRectMake(20, 170, 280, 480);

    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 40;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    //创建cell图片
    _cellLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line32.png"]];
    _cellLine.frame = CGRectMake(0, 0, 280, 40);
    
    //创建我的菜单按钮
    UIButton *myOrderBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [myOrderBut setBackgroundImage:[UIImage imageNamed:@"myorder.png"] forState:UIControlStateNormal];
    [myOrderBut addTarget:self action:@selector(myOrder) forControlEvents:UIControlEventTouchUpInside];
    if (self.index == 0)
    {
        myOrderBut.frame = CGRectMake(500, 700, 170, 40);
    }
    else
    {
       myOrderBut.frame = CGRectMake(50, 670, 200, 40);
    }
    [self.view addSubview:myOrderBut];
    
    
    //点菜按钮
    UIButton *orderBut = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.index == 0)
    {
        orderBut.frame = CGRectMake(20, 700, 80, 20);
        [orderBut setTitle:@"点菜" forState:UIControlStateNormal];
    }
    else
    {
        orderBut.frame = CGRectMake(840, 150, 80, 20);
    }
    [orderBut addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBut];
    //详细按钮
    UIButton *detailBut = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.index == 0)
    {
        detailBut.frame = CGRectMake(120, 700, 80, 20);
        [detailBut setTitle:@"详细" forState:UIControlStateNormal];
    }
    else
    {
        detailBut.frame = CGRectMake(840, 180, 80, 20);
    }
    [detailBut addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailBut];
    
    
//    [self.view bringSubviewToFront:myOrderBut];
    //**************release
    [scrImg release];
    [labelImg release];
}
//设置scroll图片 
-(void)scrollImg
{
    for (UIView *view in [_scrollView subviews])
    {
        [view removeFromSuperview];
    }

    [_arr setArray:[FMDBtool searchRowNum:self.index name:[_kindArr objectAtIndex:_select]]];
    if (self.index == 0)
    {
        _scrollView.contentSize = CGSizeMake(1024 * _arr.count, 0);
    }
    else
    {
       _scrollView.contentSize = CGSizeMake(490 * _arr.count, 0);
    }
    _scrollView.contentOffset = CGPointMake(0, 0);
    for (int i = 0; i < _arr.count; i ++)
    {
        food *f = [_arr objectAtIndex:i];
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:f.picName]];
        if (self.index == 0)
        {
            img.frame = CGRectMake(1024 * i, 0, 1024, 768);
        }
        else
        {
            img.frame = CGRectMake(490*i, 0, 490, 520);
            img.layer.cornerRadius = 20;
            img.layer.masksToBounds = YES;
 
        }
        [_scrollView addSubview:img];
        [img release];
    }

}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_select == section)
    {
        return [FMDBtool searchRowNum:self.index name:[_kindArr objectAtIndex:section]].count;
    }
    return 0;
}
//布局单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"]autorelease];
        cell.backgroundColor = [UIColor clearColor];
    }
    food *f = [[FMDBtool searchRowNum:self.index name:[_kindArr objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",f.name];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@",f.price,f.unit];
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == _selectRow)
    {
        [cell.contentView addSubview:_cellLine];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.618];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cell cache:YES];
        [UIView commitAnimations];
    }
    return cell;
}
//返回区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _kindArr.count;
}
//设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setBackgroundImage:[UIImage imageNamed:@"line31.png"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setTitle:[_kindArr objectAtIndex:section] forState:UIControlStateNormal];
//    but.backgroundColor = [UIColor redColor];
    but.tag = section + 1;
    return but;
}
//点击区头按钮
-(void)butClick:(UIButton*)but
{
    _selectRow = 0;
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    //判断点击的是不是已经打开的区  如果是  直接返回
    if (but.tag - 1 == _select)
    {
        return;
    }
    [set addIndex:_select];//添加上次的值  默认为0
    _select = but.tag - 1;//给变量赋新值
    [set addIndex:_select];//将新的值添加
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    [self scrollImg];
}
//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectRow == indexPath.row)
    {
        return;
    }
    _selectRow = indexPath.row;
    [_tableView reloadData];
    if (self.index == 0)
    {
        [_scrollView setContentOffset:CGPointMake(indexPath.row*1024, 0) animated:YES];
    }
    else
    {
        [_scrollView setContentOffset:CGPointMake(indexPath.row*490, 0) animated:YES];
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:_select] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}
//scrollView减速时使cellline移动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page;
    if (self.index == 0)
    {
        page = _scrollView.contentOffset.x/1024;
    }
    else
    {
        page = _scrollView.contentOffset.x/490;
    }
    
    if (_selectRow == page)
    {
        return;
    }
    _selectRow = page;
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:_select] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}
//点菜按钮
-(void)order
{
    food *f = [[FMDBtool searchRowNum:self.index name:[_kindArr objectAtIndex:_select]] objectAtIndex:_selectRow];
    UIImageView *copyImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:f.picName]];
//    NSLog(@"%@",copyImg);
    if (self.index == 0)
    {
        copyImg.frame = CGRectMake(0 , 0, 1027, 768);
    }
    else
    {
        copyImg.frame = CGRectMake(340 , 120, 490, 520);
    }
    [self.view addSubview:copyImg];
    [UIView beginAnimations:nil context:copyImg];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    copyImg.frame = CGRectMake(340,720, 300, 100);
    copyImg.alpha = 0.6;
    [UIView commitAnimations];
    [copyImg release];
    
    //把f写入数据
    [FMDBtool addFood:f];
    

}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *img = context;
//    NSLog(@"%@",img);
    [img removeFromSuperview];
}
//详细按钮
-(void)showDetail
{
    detailViewController *detail = [[detailViewController alloc]init];
    detail.f = [[FMDBtool searchRowNum:self.index name:[_kindArr objectAtIndex:_select]] objectAtIndex:_selectRow];
    detail.modalPresentationStyle = UIModalPresentationFormSheet;
    detail.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:detail animated:YES completion:nil];
    [detail release];
}
//我的菜单按钮
-(void)myOrder
{
    myOrderViewController *myOrderVC = [[myOrderViewController alloc]init];
    myOrderVC.modalPresentationStyle = UIModalPresentationFullScreen;
    myOrderVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myOrderVC animated:YES completion:nil];
    [myOrderVC release];
}
- (void)dealloc
{
    [_scrollView release];
    [_tableView release];
    [_picArr release];
    [_kindArr release];
    [_cellLine release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
