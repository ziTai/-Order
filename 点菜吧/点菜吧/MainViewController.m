//
//  MainViewController.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "MainViewController.h"
#import "main2ViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1111%@",NSHomeDirectory());
    //设置背景图片
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgp1.jpg"]];
    bgImg.frame = CGRectMake(0, 0, 1024, 768);
    [self.view addSubview:bgImg];
    
    //设置网站按钮
    UIButton *webButton = [UIButton buttonWithType:UIButtonTypeCustom];
    webButton.frame = CGRectMake(20, 500, 250, 30);
//    webButton.backgroundColor = [UIColor redColor];
    [webButton addTarget:self action:@selector(goToWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webButton];
    
    //进入点菜系统按钮
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.frame = CGRectMake(20,580, 250, 30);
    [orderButton addTarget:self action:@selector(goToOrderVC) forControlEvents:UIControlEventTouchUpInside];
//    orderButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:orderButton];
//************release
    [bgImg release];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.alpha = 1.0;
}
//进入网站首页
-(void)goToWeb
{
}
//进入点菜系统
-(void)goToOrderVC
{
//    NSLog(@"进入点菜主界面");
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    self.view.alpha = 0.1;
    [UIView commitAnimations];
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    main2ViewController *main2VC = [[main2ViewController alloc] init];
    main2VC.VC = self;
    UIWindow *window = [[[UIApplication sharedApplication] delegate]window];
    window.rootViewController = main2VC;
    [main2VC release];
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
