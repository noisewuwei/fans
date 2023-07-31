//
//  ReWardViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/9/13.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ReWardViewController.h"
#import "MPSPayManager.h"

@interface ReWardViewController ()<UITextFieldDelegate>{
    UITextField *textField;
}

@end

@implementation ReWardViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"打赏";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(98, 200, zScreenWidth-98*2, 39)];
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 8;
    textField.layer.borderWidth = 0.5;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    textField.returnKeyType = UIReturnKeyDone;
    textField.layer.borderColor = [[UIColor colorHexString:@"333333"] CGColor];
    [self.view addSubview:textField];
    
    
    UIButton *paybtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 250, zScreenWidth-100, 45)];
    [paybtn setBackgroundColor:[UIColor colorHexString:@"febb43"]];
    paybtn.layer.masksToBounds = YES;
    paybtn.layer.cornerRadius = 22.5;
    [paybtn setTitle:@"支 付" forState:UIControlStateNormal];
    [paybtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    paybtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [paybtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paybtn];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)pay{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"选择付款方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        
        if (textField.text.length>0) {
            [HTTPRequest postWithURL:@"api/order/addpayorder" method:@"POST" params: @{@"objectId":_str,@"totalPirce":textField.text,@"objectType":@"文章"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"first success%@",json);
                
                [self.navigationController popViewControllerAnimated:NO];
                
                
                NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
                MPSChannel channel = MPSChannelWeChat;
                [[MPSPayManager defaultManager] payWithPrice:[textField.text floatValue]*100 channel:channel withId:[json objectForKey:@"data"]];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"选择地址"];
        }
        
        
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        if (textField.text.length>0) {
            [HTTPRequest postWithURL:@"api/order/addpayorder" method:@"POST" params: @{@"objectId":_str,@"totalPirce":textField.text,@"objectType":@"文章"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"first success%@",json);
                
                [self.navigationController popViewControllerAnimated:NO];
                
                NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
                MPSChannel channel = MPSChannelAliPay;
                [[MPSPayManager defaultManager] payWithPrice:[textField.text floatValue]*100 channel:channel withId:[json objectForKey:@"data"]];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"选择地址"];
        }
        
        
        
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
