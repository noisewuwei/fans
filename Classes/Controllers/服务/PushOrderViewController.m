//
//  PushOrderViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/30.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PushOrderViewController.h"

@interface PushOrderViewController ()<UITextFieldDelegate>{
    UILabel *productNameLab;
    UITextField *name;
    UITextField *mobile;
    UITextField *qq;
}

@end

@implementation PushOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    UIImageView *bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 100, 100)];
    bigImg.contentMode = UIViewContentModeCenter;
    [back addSubview:bigImg];
    
    productNameLab = [[UILabel alloc]initWithFrame:CGRectMake(15+100+15, 15, 150, 25)];
    productNameLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    productNameLab.textColor = [UIColor colorHexString:@"383838"];
    productNameLab.textAlignment = NSTextAlignmentLeft;
    productNameLab.text = @"商品名称";
    [back addSubview:productNameLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 100+30, zScreenWidth-30, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line1];
    
    NSArray *arr = @[@"姓名",@"手机",@"QQ"];
    
    for (int i = 0; i < 3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 100+30+50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [back addSubview:line];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 100+30+10+50*i, 50, 30)];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.textColor = [UIColor colorHexString:@"383838"];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = arr[i];
        [back addSubview:label];
    }
    
    name = [[UITextField alloc]initWithFrame:CGRectMake(15, 100+30+10+50*0, 150, 30)];
    name.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    name.textAlignment = NSTextAlignmentLeft;
    name.placeholder = @"请填写您的姓名";
    [back addSubview:name];
    
    mobile = [[UITextField alloc]initWithFrame:CGRectMake(15, 100+30+10+50*1, 150, 30)];
    mobile.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    mobile.textAlignment = NSTextAlignmentLeft;
    mobile.placeholder = @"请填写您的手机号";
    [back addSubview:mobile];
    
    qq = [[UITextField alloc]initWithFrame:CGRectMake(15, 100+30+10+50*2, 150, 30)];
    qq.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    qq.textAlignment = NSTextAlignmentLeft;
    qq.placeholder = @"请填写您的QQ号 ";
    [back addSubview:qq];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    done.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [done setTitle:@"提交订单" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [done setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [back addSubview:done];
    
    // Do any additional setup after loading the view.
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
