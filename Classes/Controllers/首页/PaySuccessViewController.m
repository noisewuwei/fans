//
//  PaySuccessViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    [self createBarLeftWithImage:@"iconback"];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-80, 40, 160, 160)];
    image.image = [UIImage imageNamed:@"pay_finished_y"];
    image.contentMode = UIViewContentModeCenter;
    [self.view addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-80, 40+160+20, 160, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    label.textColor = [UIColor colorHexString:@"383838"];
    label.text = @"支付成功";
    [self.view addSubview:label];
    
    UIButton *orderBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 40+160+20+30+30, zScreenWidth/2-30, 40)];
    [orderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    orderBtn.layer.masksToBounds = YES;
    orderBtn.layer.cornerRadius = 20;
    orderBtn.layer.borderColor = [[UIColor colorHexString:@"ffffff"]CGColor];
    orderBtn.layer.borderWidth = 1;
    [orderBtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [orderBtn addTarget: self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self.view addSubview:orderBtn];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+15, 40+160+20+30+30, zScreenWidth/2-30, 40)];
    [backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = 20;
    [backBtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [backBtn addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [self.view addSubview:backBtn];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)order{
    
}

- (void)back{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
