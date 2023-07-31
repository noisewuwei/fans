//
//  FindPassViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/21.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FindPassViewController.h"
#import "ReSetPwdViewController.h"

@interface FindPassViewController ()<UITextFieldDelegate>{
    UITextField *phoneLab;
    UITextField *verityLab;
    UIButton *getcodeBtn;
}

@end

@implementation FindPassViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"密码找回";
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
    
    UIButton *loginbtn = [[UIButton alloc]initWithFrame:CGRectMake(50, line1.frame.origin.y+26, zScreenWidth-100, 45)];
    [loginbtn setBackgroundColor:[UIColor colorHexString:@"febb43"]];
    loginbtn.layer.masksToBounds = YES;
    loginbtn.layer.cornerRadius = 22.5;
    [loginbtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginbtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [loginbtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    
    // Do any additional setup after loading the view.
}

- (void)next{
    
    [HTTPRequest postWithURL:@"/api/member/checkcode" method:@"POST" params:@{@"account":phoneLab.text,@"accountType":@"0",@"checkCode":verityLab.text} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"login success%@",json);
        
        ReSetPwdViewController *rvc = [[ReSetPwdViewController alloc]init];
        rvc.phone = phoneLab.text;
        rvc.code = verityLab.text;
        [self.navigationController pushViewController:rvc animated:YES];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
}


- (void)getcode{
    [self setTheCountdownButton:getcodeBtn startWithTime:59 title:@"重新获取" countDownTitle:@"" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    
    if ([ZJStaticFunction isMobileNumber:phoneLab.text]) {
        [HTTPRequest postWithURL:@"api/message/sendVerifyCode" method:@"POST" params:@{@"account":phoneLab.text,@"messageType":@"1",@"accountType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
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
