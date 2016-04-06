//
//  main2ViewController.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "main2ViewController.h"
#import "orderViewController.h"
#import "FMDBtool.h"
@interface main2ViewController ()

@end

@implementation main2ViewController

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
    UIImageView *bgimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgpp2.jpg"]];
    bgimg.frame = CGRectMake(0, 0, 1024, 768);
    [self.view addSubview:bgimg];
    
    //中文按钮
    UIButton *chinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chinaButton.frame = CGRectMake(412, 480, 200, 50);
    [chinaButton addTarget:self action:@selector(goToOAnimation:) forControlEvents:UIControlEventTouchUpInside];
    chinaButton.tag = 1;
    [self.view addSubview:chinaButton];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(350, 610, 180, 50);
    [backButton addTarget:self action:@selector(goToOAnimation:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 2;
    [self.view addSubview:backButton];
    
    //历史按钮
    UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    historyButton.backgroundColor = [UIColor redColor];
    [historyButton addTarget:self action:@selector(history) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyButton];
    
    //复制数据库文件
    [self copySqlite];
    
//***********release
    [bgimg release];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.alpha = 1.0;
}
-(void)history
{
}
//跳转动画
-(void)goToOAnimation:(UIButton *)but
{
    NSString *str = [NSString stringWithFormat:@"+++%d",but.tag];
    [UIView beginAnimations:str context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    self.view.alpha = 0.1;
    [UIView commitAnimations];
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"+++1"])
    {
        orderViewController *orderVC = [[orderViewController alloc] init];
        orderVC.VC = self;
        UIWindow *window = [[[UIApplication sharedApplication] delegate]window];
        window.rootViewController = orderVC;
        [orderVC release];
    }
    else
    {
//        MainViewController *mainVC = [[MainViewController alloc] init];
        UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
        window.rootViewController = self.VC;
//        [mainVC release];
    }

}
-(void)copySqlite
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
    NSString *destinationPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    
    NSString *path = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/database.sqlite"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSLog(@"文件已存在,不用复制");
        return;
    }
    else
    {
        NSLog(@"文件不存在，需要重新复制");
        //将一个文件(夹)复制到另外一个地方
        //参数1:被复制的文件(夹)路径,参数2:要被复制到的路径.
        //文件或文件夹被复制的时候目的路径上的新文件名字可以自己再定义,复制后内容是相同的.
        if ([[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:nil])
        {
            NSLog(@"复制成功");
        }
        else
        {
            NSLog(@"复制失败");
        }

    }
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
