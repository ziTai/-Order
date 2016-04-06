//
//  detailViewController.m
//  点菜吧
//
//  Created by mac on 15-12-5.
//  Copyright (c) 2015年 ShiGonXun. All rights reserved.
//

#import "detailViewController.h"
#import "FMDBtool.h"
@interface detailViewController ()


@end

@implementation detailViewController

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
    [self uivew];
    
    food *f = self.f;
    UIImageView *bgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgp5"]];
    bgImg.frame = CGRectMake(0, 0, 550, 630);
    [self.view addSubview:bgImg];
    
    
    [bgImg release];
    
    UIImageView *picImg = [[UIImageView alloc]initWithFrame:CGRectMake(21, 20, 320, 450)];
    picImg.image = [UIImage imageNamed:f.picName];
    [self.view addSubview:picImg];
    
    [picImg release];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(350, 60, 180, 30)];
    nameLabel.text = [NSString stringWithFormat:@"%@  %@/%@",f.name,f.price,f.unit];
    nameLabel.textColor = [UIColor yellowColor];
    [self.view addSubview:nameLabel];
    [nameLabel release];
    
    UILabel *detaillabel = [[UILabel alloc]initWithFrame:CGRectMake(345, 260, 180, 300)];
    detaillabel.numberOfLines = 0;
    detaillabel.text = f.detail;
    detaillabel.textAlignment = NSTextAlignmentCenter;
    detaillabel.textColor = [UIColor yellowColor];
    [self.view addSubview:detaillabel];
    [detaillabel release];
}
-(void)uivew
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.678];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    [UIView commitAnimations];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    [_f release];
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
