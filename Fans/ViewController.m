//
//  ViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FirstViewController *firstvc = [FirstViewController alloc];
    UINavigationController *firstn = [[UINavigationController alloc]initWithRootViewController:firstvc];
    firstn.tabBarItem.title = @"首页";
    
    firstn.tabBarItem.image = [[UIImage imageNamed:@"tapbar_menu_1_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    firstn.tabBarItem.selectedImage = [[UIImage imageNamed:@"tapbar_menu_1_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorHexString:@"#999999"],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [firstn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    NSShadow *shad = [[NSShadow alloc] init];
    shad.shadowColor = [UIColor whiteColor];
    NSDictionary *selectDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorHexString:@"#1a2f55"],NSForegroundColorAttributeName,shad,NSShadowAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil];
    [firstn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    SecondViewController *secondvc = [SecondViewController alloc];
    UINavigationController *secondn = [[UINavigationController alloc]initWithRootViewController:secondvc];
    secondn.tabBarItem.title = @"饭圈";
    
    secondn.tabBarItem.image = [[UIImage imageNamed:@"tapbar_menu_2_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    secondn.tabBarItem.selectedImage = [[UIImage imageNamed:@"tapbar_menu_2_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [secondn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [secondn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    
    
    ThirdViewController *thirdvc = [ThirdViewController alloc];
    UINavigationController *thirdn = [[UINavigationController alloc]initWithRootViewController:thirdvc];
    thirdn.tabBarItem.title = @"idol";
    
    thirdn.tabBarItem.image = [[UIImage imageNamed:@"tapbar_menu_3_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    thirdn.tabBarItem.selectedImage = [[UIImage imageNamed:@"tapbar_menu_3_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    [thirdn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [thirdn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    FourthViewController *fourthvc = [FourthViewController alloc];
    UINavigationController *fourthn = [[UINavigationController alloc]initWithRootViewController:fourthvc];
    
    fourthn.tabBarItem.title = @"服务";
    
    fourthn.tabBarItem.image = [[UIImage imageNamed:@"tapbar_menu_4_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    fourthn.tabBarItem.selectedImage = [[UIImage imageNamed:@"tapbar_menu_4_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    [fourthn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [fourthn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    FifthViewController *fifthvc = [FifthViewController alloc];
    UINavigationController *fifthn = [[UINavigationController alloc]initWithRootViewController:fifthvc];
    fifthn.tabBarItem.title = @"我的";
    
    fifthn.tabBarItem.image = [[UIImage imageNamed:@"tapbar_menu_5_normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    fifthn.tabBarItem.selectedImage = [[UIImage imageNamed:@"tapbar_menu_5_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置tabbar的title的颜色，字体大小，阴影
    [fifthn.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    [fifthn.tabBarItem setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    
    NSArray *arr = @[firstn,secondn,thirdn,fourthn,fifthn];
    
    [self setViewControllers:arr animated:YES];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([ZJStoreDefaults getObjectForKey:@"userinfo"]) {
        NSDictionary *userdic = [NSDictionary dictionary];
        userdic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
        
        [HTTPRequest postWithURL:@"api/member/login" method:@"POST" params:@{@"account":[userdic objectForKey:@"mobile"],@"password":[userdic objectForKey:@"password"]} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"login success%@",json);
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            [ZJStoreDefaults setObject:[dic objectForKey:@"data"] forKey:@"userinfo"];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeinfo" object:nil userInfo:nil];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];

    }else{
        LoginViewController *lgvc = [[LoginViewController alloc] init];
        UINavigationController *lgn = [[UINavigationController alloc]initWithRootViewController:lgvc];
        [self presentViewController:lgn animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
