//
//  ViewController.m
//  点菜吧
//
//  Created by mac on 15-12-3.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //测试使用                        
    [self animationDidStop:nil finished:nil context:nil];
    //开机帧动画
    UIImage *img1 = [UIImage imageNamed:@"01.png"];
    UIImage *img2 = [UIImage imageNamed:@"02.png"];
    NSArray *arr = [[NSArray alloc] initWithObjects:img1,img2, nil];
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    bgImg.animationImages = arr;
    bgImg.animationDuration = 0.5;
    [bgImg startAnimating];
    [self.view addSubview:bgImg];
    [self performSelector:@selector(goToMainVC:) withObject:bgImg afterDelay:1];
    
    [bgImg release];
    [arr release];
}
-(void)goToMainVC:(UIImageView *)img
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    img.alpha = 0.1;
    [UIView commitAnimations];

}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    window.rootViewController = mainVC;
    [mainVC release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
