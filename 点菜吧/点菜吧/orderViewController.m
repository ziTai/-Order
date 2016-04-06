//
//  orderViewController.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "orderViewController.h"
@interface orderViewController ()
{
    NSMutableArray *_picArray;
    NSMutableArray *_highArray;
    int            _Select;
    UITableView     *_catalogueTableView;
    UIButton        *_backButton;
}

@end

@implementation orderViewController

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
    
    _picArray = [[NSMutableArray alloc] initWithCapacity:0];
    _highArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIImageView *bgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgp3.png"]];
//    UIImageView *tableImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btnBG.png"]];
    [self.view addSubview:bgImg];
    //创建目录的tableView
    _catalogueTableView = [[UITableView alloc] initWithFrame:CGRectMake(950, 50, 50, 668) style:UITableViewStyleGrouped];
    _catalogueTableView.rowHeight = (618 - 50)/6.0;
    _catalogueTableView.backgroundColor = [UIColor blackColor];
//    [catalogueTableView setBackgroundView:tableImg];
    _catalogueTableView.delegate = self;
    _catalogueTableView.dataSource = self;
    
    [self.view addSubview:_catalogueTableView];
    
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(goToMain2VC) forControlEvents:UIControlEventTouchUpInside];
    _backButton.frame = CGRectMake(950, 0, 50, 50);
    [self.view addSubview:_backButton];
    
    [_picArray setArray:[[FMDBtool searchGroupTable] objectAtIndex:0]];
    [_highArray setArray:[[FMDBtool searchGroupTable] objectAtIndex:1]];
    
    for (int i = 0; i < _picArray.count; i ++)
    {
        recommendViewController *recVC = [[[recommendViewController alloc] init]autorelease];
        recVC.index = i;
        [self addChildViewController:recVC];
    }
    [self tableView:nil didSelectRowAtIndexPath:0];

//*************release
    [bgImg release];
}
-(void)goToMain2VC
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    self.view.alpha = 0.1;
    [UIView commitAnimations];
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    [[[UIApplication sharedApplication] delegate]window].rootViewController = self.VC;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _picArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"]autorelease];
        UIImageView *imgView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, (618 - 50)/6.0)]autorelease];
        imgView.tag = 1;
        [cell.contentView addSubview:imgView];
    }
    UIImageView *img = (UIImageView *)[cell viewWithTag:1];
    if (_Select == indexPath.row)
    {
        img.image = [UIImage imageNamed:[_highArray objectAtIndex:indexPath.row]];
    }
    else
    {
        img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_picArray objectAtIndex:indexPath.row]]];
    }
    cell.backgroundColor = [UIColor blackColor];
     return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _Select = indexPath.row;
    [tableView reloadData];
    recommendViewController *recVC = [self.childViewControllers objectAtIndex:_Select];
    [self.view addSubview:recVC.view];
    [self.view bringSubviewToFront:_catalogueTableView];
    [self.view bringSubviewToFront:_backButton];
}
- (void)dealloc
{
    [_picArray release];
    [_highArray release];
    [_VC release];
    [_catalogueTableView release];
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
