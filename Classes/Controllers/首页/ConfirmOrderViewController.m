//
//  ConfirmOrderViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/10.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import <MOBFoundation/MOBFoundation.h>
#import "MPSPayManager.h"
#import "AddressListViewController.h"

@interface ConfirmOrderViewController ()<UITextFieldDelegate>{
    UILabel *lab;
    UIImageView *bigImg;
    UILabel *titleLab;
    UILabel *typeLab;
    UILabel *moneyLab;
    UILabel *numLab;
    
    UILabel *sendmoneyLab;
    UITextField *textfield;
    UILabel *totalLab;
    int i;
    
    
    UILabel *address;
    UILabel *name;
    UILabel *phone;
    
    NSString *rid;
}

@end

@implementation ConfirmOrderViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    typeLab.text = _type;
    
    numLab.text = _num;
    
    moneyLab.text = _price;
    
    titleLab.text = _str;
    
    totalLab.text = [NSString stringWithFormat:@"¥ %0.2f",[_price floatValue]*[_num intValue]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    i = 1;
    
    self.title = @"确认订单";
    [self createBarLeftWithImage:@"iconback"];
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 50)];
    
    [Btn addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    
    [back addSubview:Btn];
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 30)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    lab.textColor = [UIColor colorHexString:@"383838"];
    lab.text = @"添加收货地址";
    [back addSubview:lab];
    
    address = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, zScreenWidth-30, 20)];
    address.textAlignment = NSTextAlignmentLeft;
    address.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    address.textColor = [UIColor colorHexString:@"383838"];
    address.text = @"江苏省南通市崇川区科技园";
    [back addSubview:address];
    
    name = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 80, 20)];
    name.textAlignment = NSTextAlignmentLeft;
    name.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    name.textColor = [UIColor colorHexString:@"777777"];
    name.text = @"啦啦啦";
    [back addSubview:name];
    
    phone = [[UILabel alloc]initWithFrame:CGRectMake(15+80, 25, 150, 20)];
    phone.textAlignment = NSTextAlignmentLeft;
    phone.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    phone.textColor = [UIColor colorHexString:@"777777"];
    phone.text = @"1234567890";
    [back addSubview:phone];
    
    address.hidden = YES;
    name.hidden = YES;
    phone.hidden = YES;
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-20, 15, 20, 20)];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"icon_more"];
    [back addSubview:image];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 50, zScreenWidth-30, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line1];
    
    bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, line1.frame.origin.y+14, 100, 100)];
    bigImg.contentMode = UIViewContentModeCenter;
    bigImg.backgroundColor = [UIColor blackColor];
    [back addSubview:bigImg];
    
    
    titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, bigImg.frame.origin.y, 250, 20)];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    titleLab.textColor = [UIColor colorHexString:@"383838"];
    titleLab.text = @"朴灿烈的生日商品";
    [back addSubview:titleLab];
    
    typeLab = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, bigImg.frame.origin.y+20+10, 150, 20)];
    typeLab.textAlignment = NSTextAlignmentLeft;
    typeLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    typeLab.textColor = [UIColor colorHexString:@"383838"];
    [back addSubview:typeLab];
    
    moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, bigImg.frame.origin.y+100-20, 150, 20)];
    moneyLab.textAlignment = NSTextAlignmentLeft;
    moneyLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    moneyLab.textColor = [UIColor colorHexString:@"383838"];
    [back addSubview:moneyLab];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, bigImg.frame.origin.y+100+14, zScreenWidth-30, 1)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.frame.origin.y+10, 150, 30)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label1.textColor = [UIColor colorHexString:@"383838"];
    label1.text = @"选择数量";
    [back addSubview:label1];
    
    numLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth-15-30-40, label1.frame.origin.y, 40, 30)];
    numLab.textAlignment = NSTextAlignmentCenter;
    numLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [back addSubview:numLab];
    
    
    UIButton *plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(zScreenWidth-15-30, label1.frame.origin.y+2.5, 25, 25)];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"pay_+"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:plusBtn];
    
    UIButton *minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(zScreenWidth-15-30-40-30, label1.frame.origin.y+2.5, 25, 25)];
    [minusBtn setBackgroundImage:[UIImage imageNamed:@"pay_-"] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:minusBtn];
    
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(15, line2.frame.origin.y+50, zScreenWidth-30, 1)];
    line3.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line3];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, line3.frame.origin.y+10, 150, 30)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label2.textColor = [UIColor colorHexString:@"383838"];
    label2.text = @"运费";
    [back addSubview:label2];
    
    sendmoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth-15-50, label2.frame.origin.y, 40, 30)];
    sendmoneyLab.text = @"¥ 0";
    sendmoneyLab.textAlignment = NSTextAlignmentRight;
    sendmoneyLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [back addSubview:sendmoneyLab];
    
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(15, line3.frame.origin.y+50, zScreenWidth-30, 1)];
    line4.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line4];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, line4.frame.origin.y+10, 50, 30)];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label3.textColor = [UIColor colorHexString:@"383838"];
    label3.text = @"留言：";
    [back addSubview:label3];
    
    textfield = [[UITextField alloc]initWithFrame:CGRectMake(15+50, label3.frame.origin.y, zScreenWidth-30-50, 30)];
    textfield.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    textfield.placeholder = @"请填写留言";
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeyDone;
    [back addSubview:textfield];
    
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    [self.view addSubview:bottomview];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-50, zScreenWidth, 1)];
    line5.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:line5];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-130, 0, 130, 49)];
    [doneBtn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [doneBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [bottomview addSubview:doneBtn];
    
    UILabel *downLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-130-80-60, 10, 60, 30)];
    downLab.textAlignment = NSTextAlignmentRight;
    downLab.textColor = [UIColor colorHexString:@"383838"];
    downLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    downLab.text = @"合计：";
    [bottomview addSubview:downLab];
    
    totalLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-130-80, 10, 80, 30)];
    totalLab.textAlignment = NSTextAlignmentCenter;
    totalLab.textColor = [UIColor colorHexString:@"fd7e82"];
    totalLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    
    [bottomview addSubview:totalLab];
    
    
    // Do any additional setup after loading the view.
}

- (void)selectAddress{
    AddressListViewController *avc = [[AddressListViewController alloc]init];
    avc.str = @"callback";
    avc.callBack = ^(NSDictionary *dic){
        
        address.text = [NSString stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"area"],[dic objectForKey:@"address"]];
        name.text = [dic objectForKey:@"name"];
        phone.text = [dic objectForKey:@"mobile"];
        
        rid = [dic objectForKey:@"receiverId"];
        
        lab.hidden = YES;
        address.hidden = NO;;
        name.hidden = NO;
        phone.hidden = NO;
        
    };
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)done{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"选择付款方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"num%@",_num);
        NSLog(@"price%@",_price);
        
        NSString *str = [NSString stringWithFormat:@"%f",[_price floatValue]*[_num intValue]];
        NSLog(@"price=====%@",str);
        
        if (rid.length>0) {
            [HTTPRequest postWithURL:@"api/order/addpayorder" method:@"POST" params: @{@"shopName":_str,@"receiverId":rid,@"payType":@"微信",@"objectId":_objectId,@"objectType":@"活动",@"productId":_type,@"productNum":_num,@"totalPirce":str,@"remark":textfield.text} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"first success%@",json);
                
                
                NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
                MPSChannel channel = MPSChannelWeChat;
                [[MPSPayManager defaultManager] payWithPrice:[str floatValue]*100 channel:channel withId:[json objectForKey:@"data"]];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"选择地址"];
        }
        
        
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *str = [NSString stringWithFormat:@"%f",[_price floatValue]*[_num intValue]];
        NSLog(@"price=====%@",str);
        
        if (rid.length>0) {
            [HTTPRequest postWithURL:@"api/order/addpayorder" method:@"POST" params: @{@"shopName":_str,@"receiverId":rid,@"payType":@"支付宝",@"objectId":_objectId,@"objectType":@"活动",@"productId":_type,@"productNum":_num,@"totalPirce":str,@"remark":textfield.text} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"first success%@",json);
                
                
                NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
                MPSChannel channel = MPSChannelAliPay;
                [[MPSPayManager defaultManager] payWithPrice:[str floatValue]*100 channel:channel withId:[json objectForKey:@"data"]];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else{
            [ZJStaticFunction alertView:self.view msg:@"选择地址"];
        }
        
        
        
        
        
    }]];
    
     [self presentViewController:alertController animated:YES completion:nil];
    
    

}

- (void)plus:(UIButton *)sender{
    
    i++;
    numLab.text = [NSString stringWithFormat:@"%d",i];
    _num = [NSString stringWithFormat:@"%d",i];
    totalLab.text = [NSString stringWithFormat:@"¥ %0.2f",[_price floatValue]*[_num intValue]];

}

- (void)minus:(UIButton *)sender{
    
    if (i > 1) {
        i--;
        numLab.text = [NSString stringWithFormat:@"%d",i];
        _num = [NSString stringWithFormat:@"%d",i];
        totalLab.text = [NSString stringWithFormat:@"¥ %0.2f",[_price floatValue]*[_num intValue]];
    }

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
