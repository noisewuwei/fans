//
//  ReSetPwdViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/22.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ReSetPwdViewController.h"

@interface ReSetPwdViewController ()<UITextFieldDelegate>{
    UITextField *phoneLab;
    UITextField *verityLab;
}

@end

@implementation ReSetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+18, 14, 14)];
    phoneImg.contentMode = UIViewContentModeCenter;
    phoneImg.image = [UIImage imageNamed:@"icon_password"];
    [self.view addSubview:phoneImg];
    
    
    phoneLab = [[UITextField alloc]initWithFrame:CGRectMake(phoneImg.frame.origin.x+14+14, phoneImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    phoneLab.placeholder = @"请输入新密码";
    phoneLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    phoneLab.delegate = self;
    phoneLab.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:phoneLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+50, zScreenWidth-110, 0.5)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, phoneImg.frame.origin.y+18+18+14, 14, 14)];
    codeImg.contentMode = UIViewContentModeCenter;
    codeImg.image = [UIImage imageNamed:@"icon_password"];
    [self.view addSubview:codeImg];
    
    
    verityLab = [[UITextField alloc]initWithFrame:CGRectMake(codeImg.frame.origin.x+14+14, codeImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    verityLab.placeholder = @"请再次输入新密码";
    verityLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    verityLab.delegate = self;
    verityLab.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:verityLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+50+50, zScreenWidth-110, 0.5)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line1];
    
    UIButton *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, line1.frame.origin.y+26, zScreenWidth-100, 45)];
    [loginbtn setBackgroundColor:[UIColor colorHexString:@"febb43"]];
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.cornerRadius = 22.5;
    [loginbtn setTitle:@"完成" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [loginbtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)done{
    
    [HTTPRequest postWithURL:@"/api/member/updatePassword" method:@"POST" params:@{@"account":_phone,@"password":phoneLab.text,@"checkCode":_code,@"accountType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"regi success%@",json);
        
        
        [HTTPRequest postWithURL:@"api/member/login" method:@"POST" params:@{@"account":_phone,@"password":verityLab.text} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"login success%@",json);
            
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            [ZJStoreDefaults setObject:[dic objectForKey:@"data"] forKey:@"userinfo"];
            
            [self dismissViewControllerAnimated:NO completion:nil];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
        
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
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
