//
//  RegisterViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/21.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    
    UITextField *phoneLab;
    UITextField *verityLab;
    UITextField *passwordLab;
    UIButton *getcodeBtn;
    UIButton *seeBtn;
}

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机注册";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+18, 14, 14)];
    phoneImg.contentMode = UIViewContentModeCenter;
    phoneImg.image = [UIImage imageNamed:@"icon_username"];
    [self.view addSubview:phoneImg];
    
    
    phoneLab = [[UITextField alloc]initWithFrame:CGRectMake(phoneImg.frame.origin.x+14+14, phoneImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    phoneLab.placeholder = @"请输入手机号";
    phoneLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    phoneLab.delegate = self;
    phoneLab.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:phoneLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+50, zScreenWidth-110, 0.5)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, phoneImg.frame.origin.y+18+18+14, 14, 14)];
    codeImg.contentMode = UIViewContentModeCenter;
    codeImg.image = [UIImage imageNamed:@"icon_yanzheng"];
    [self.view addSubview:codeImg];
    
    
    verityLab = [[UITextField alloc]initWithFrame:CGRectMake(codeImg.frame.origin.x+14+14, codeImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    verityLab.placeholder = @"请输入验证码";
    verityLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    verityLab.delegate = self;
    verityLab.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:verityLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+50+50, zScreenWidth-110, 0.5)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line1];
    
    UIImageView *pwdImg = [[UIImageView alloc]initWithFrame:CGRectMake(55, codeImg.frame.origin.y+18+18+14, 14, 14)];
    pwdImg.contentMode = UIViewContentModeCenter;
    pwdImg.image = [UIImage imageNamed:@"icon_password"];
    [self.view addSubview:pwdImg];
    
    
    passwordLab = [[UITextField alloc]initWithFrame:CGRectMake(pwdImg.frame.origin.x+14+14, pwdImg.frame.origin.y-8, zScreenWidth-55-14-14-55, 30)];
    passwordLab.placeholder = @"请输入6-16位密码";
    passwordLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    passwordLab.delegate = self;
    passwordLab.returnKeyType = UIReturnKeyDone;
    passwordLab.secureTextEntry = YES;
    [self.view addSubview:passwordLab];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(55, zNavigationHeight+16+50+100, zScreenWidth-110, 0.5)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line2];
    
    UIButton *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, line2.frame.origin.y+26, zScreenWidth-100, 45)];
    [loginbtn setBackgroundColor:[UIColor colorHexString:@"febb43"]];
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.cornerRadius = 22.5;
    [loginbtn setTitle:@"注 册" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [loginbtn addTarget:self action:@selector(regi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    
    getcodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(verityLab.frame.size.width-80, 0, 80, 30)];
    getcodeBtn.layer.masksToBounds = YES;
    getcodeBtn.layer.cornerRadius = 15;
    getcodeBtn.layer.borderWidth = 0.5;
    getcodeBtn.layer.borderColor = [[UIColor colorHexString:@"383838"]CGColor];
    [getcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getcodeBtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    getcodeBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    [getcodeBtn addTarget:self action:@selector(getcode) forControlEvents:UIControlEventTouchUpInside];
    [verityLab addSubview:getcodeBtn];
    
    seeBtn = [[UIButton alloc]initWithFrame:CGRectMake(passwordLab.frame.size.width-20, 5, 20, 20)];
    [seeBtn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [seeBtn setBackgroundImage:[UIImage imageNamed:@"形状1"] forState:UIControlStateNormal];
    [seeBtn setBackgroundImage:[UIImage imageNamed:@"icon_eyes_open"] forState:UIControlStateSelected];
    seeBtn.selected = NO;
    seeBtn.tag = 100;
    [passwordLab addSubview:seeBtn];
    
    UILabel *agreeLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-100, zScreenHeight-50, 200, 20)];
    agreeLab.textAlignment = NSTextAlignmentCenter;
    agreeLab.textColor = [UIColor blackColor];
    agreeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    agreeLab.text = @"同意《饭圈儿APP用户协议》";
    [self.view addSubview:agreeLab];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(agreeLab.frame.origin.x-20, agreeLab.frame.origin.y, 20, 20)];
    [agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_unagree"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateSelected];
    agreeBtn.selected = NO;
    agreeBtn.tag = 100;
    [self.view addSubview:agreeBtn];
    
    // Do any additional setup after loading the view.
}

- (void)choose:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if(sender.selected == NO){
        passwordLab.secureTextEntry = YES;
    }
    else{
        passwordLab.secureTextEntry = NO;
    }
    
}

- (void)agree:(UIButton *)sender{
    
    sender.selected = !sender.selected;
//    if(sender.selected == NO){
//        passwordLab.secureTextEntry = YES;
//    }
//    else{
//        passwordLab.secureTextEntry = NO;
//    }
    
}

- (void)see{
    
}

- (void)regi{
    
    [HTTPRequest postWithURL:@"api/member/regist" method:@"POST" params:@{@"account":phoneLab.text,@"password":passwordLab.text,@"checkCode":verityLab.text,@"accountType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"regi success%@",json);
        
        
        [HTTPRequest postWithURL:@"api/member/login" method:@"POST" params:@{@"account":phoneLab.text,@"password":passwordLab.text} ProgressHUD:self.Hud controller:self response:^(id json) {
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

- (void)getcode{
    
    [self setTheCountdownButton:getcodeBtn startWithTime:59 title:@"重新获取" countDownTitle:@"" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    
    
    if ([ZJStaticFunction isMobileNumber:phoneLab.text]) {
        [HTTPRequest postWithURL:@"api/message/sendVerifyCode" method:@"POST" params:@{@"account":phoneLab.text,@"messageType":@"0",@"accountType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"getcode success %@",json);
            
            
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"输入正确的手机号"];
    }
    
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle: title forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@(%@)",subTitle,timeStr]forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
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
