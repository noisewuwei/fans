//
//  LoginViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/21.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPassViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField *phoneLab;
    UITextField *passwordLab;
}

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-55, 89, 110, 110)];
    headImg.contentMode = UIViewContentModeCenter;
    headImg.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:headImg];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, headImg.frame.origin.y+110+40+18, 14, 14)];
    phoneImg.contentMode = UIViewContentModeCenter;
    phoneImg.image = [UIImage imageNamed:@"icon_username"];
    [self.view addSubview:phoneImg];
    
    phoneLab = [[UITextField alloc]initWithFrame:CGRectMake(phoneImg.frame.origin.x+14+14, phoneImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    phoneLab.placeholder = @"请输入手机号/邮箱";
    phoneLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    phoneLab.delegate = self;
    phoneLab.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:phoneLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(55, headImg.frame.origin.y+110+40+50, zScreenWidth-110, 0.5)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line];
    
    UIImageView *passwordImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, headImg.frame.origin.y+110+40+50+20, 14, 14)];
    passwordImg.contentMode = UIViewContentModeCenter;
    passwordImg.image = [UIImage imageNamed:@"icon_password"];
    [self.view addSubview:passwordImg];
    
    passwordLab = [[UITextField alloc]initWithFrame:CGRectMake(passwordImg.frame.origin.x+14+14, passwordImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    passwordLab.placeholder = @"请输入密码";
    passwordLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    passwordLab.delegate = self;
    passwordLab.returnKeyType = UIReturnKeyDone;
    passwordLab.secureTextEntry = YES;
    [self.view addSubview:passwordLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(55, headImg.frame.origin.y+110+40+50+50, zScreenWidth-110, 0.5)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line1];
    
    UIButton *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, zScreenHeight-250, zScreenWidth-100, 45)];
    [loginbtn setBackgroundColor:[UIColor colorHexString:@"febb43"]];
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.cornerRadius = 22.5;
    [loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [loginbtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    UIButton *regibtn = [[UIButton alloc]initWithFrame:CGRectMake(50, zScreenHeight-200, 40, 49)];
    [regibtn setTitle:@"注册" forState:UIControlStateNormal];
    [regibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    regibtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [regibtn addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regibtn];
    
    UIButton *fogetbtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-50-70, zScreenHeight-200, 70, 49)];
    [fogetbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [fogetbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fogetbtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [fogetbtn addTarget:self action:@selector(foget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fogetbtn];
    
    
    UILabel *thirdlogin = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-50, zScreenHeight-100, 100, 20)];
    thirdlogin.textAlignment = NSTextAlignmentCenter;
    thirdlogin.text = @"第三方登录";
    thirdlogin.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    thirdlogin.textColor = [UIColor colorHexString:@"383838"];
    [self.view addSubview:thirdlogin];
    
    UIView *aline = [[UIView alloc]initWithFrame:CGRectMake(50, zScreenHeight-100+10, zScreenWidth/2-50-100, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"c7c7c7"];
    [self.view addSubview:aline];
    
    UIView *bline = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/2+50, zScreenHeight-100+10, zScreenWidth/2-50-100, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"c7c7c7"];
    [self.view addSubview:bline];
    
    UIButton *weiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-18-36-36, zScreenHeight-70, 36, 36)];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
    [self.view addSubview:weiboBtn];
    
    UIButton *qqBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-18, zScreenHeight-70, 36, 36)];
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
    [self.view addSubview:qqBtn];
    
    UIButton *wxBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+18+36, zScreenHeight-70, 36, 36)];
    [wxBtn setBackgroundImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];
    [self.view addSubview:wxBtn];
    
    // Do any additional setup after loading the view. 
}

- (void)login{
    [HTTPRequest postWithURL:@"api/member/login" method:@"POST" params:@{@"account":phoneLab.text,@"password":passwordLab.text} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"login success%@",json);
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
        [ZJStoreDefaults setObject:[dic objectForKey:@"data"] forKey:@"userinfo"];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)regi{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (void)foget{
    FindPassViewController *fvc = [[FindPassViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
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
