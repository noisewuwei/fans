//
//  AddAdressViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddAdressViewController.h"
#import "MOFSPickerManager.h"

@interface AddAdressViewController ()<UITextFieldDelegate,UITextViewDelegate>{
    UITextField *name;
    UITextField *phoneNum;
    UIButton *selectAddress;
    UITextView *address;
    UILabel *pleLab;
    NSString *addressstr;
    NSString *typeStr;
    UIButton *adressButton;
}

@end

@implementation AddAdressViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    if (_dic.count>0) {
        name.text = [_dic objectForKey:@"name"];
        phoneNum.text = [_dic objectForKey:@"mobile"];
        address.text = [_dic objectForKey:@"address"];
        pleLab.hidden = YES;
        [selectAddress setTitle:[NSString stringWithFormat:@"%@-%@-%@",[_dic objectForKey:@"province"],[_dic objectForKey:@"city"],[_dic objectForKey:@"area"]] forState:UIControlStateNormal];
        addressstr = [NSString stringWithFormat:@"%@-%@-%@",[_dic objectForKey:@"province"],[_dic objectForKey:@"city"],[_dic objectForKey:@"area"]];
        
        typeStr = [_dic objectForKey:@"isDefault"];
        
        if ([[_dic objectForKey:@"isDefault"] isEqualToString:@"是"]) {
            adressButton.selected = YES;
        }else{
            adressButton.selected = NO;
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typeStr = @"否";
    
    self.title = @"添加收货地址";
    [self createBarLeftWithImage:@"iconback"];
    [self createRightTitle:@"完成" titleColor:[UIColor colorHexString:@"383838"]];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth,zScreenHeight)];
    back.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [self.view addSubview:back];
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, 324)];
    white.backgroundColor = [UIColor whiteColor];
    [back addSubview:white];
    
    for (int i = 0; i < 3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [white addSubview:line];
    }
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 200+80, zScreenWidth-30, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [white addSubview:line1];
    
    NSArray *arr = @[@"姓名",@"手机号",@"所在地区",@"详细地址"];
    
    for (int i = 0; i < arr.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50*i, 80, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr[i];
        [white addSubview:label];
        
    }
    
    name = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*0, zScreenWidth-15-110, 30)];
    name.placeholder = @"请输入您的姓名";
    name.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    name.delegate = self;
    name.returnKeyType = UIReturnKeyDone;
    name.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:name];
    
    phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(110, 10+50*1, zScreenWidth-15-110, 30)];
    phoneNum.placeholder = @"请输入手机号码";
    phoneNum.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    phoneNum.delegate = self;
    phoneNum.returnKeyType = UIReturnKeyDone;
    phoneNum.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:phoneNum];
    
    selectAddress = [[UIButton alloc]initWithFrame:CGRectMake(110, 10+50*2, zScreenWidth-15-110-30, 30)];
    [selectAddress setTitle:@"点击选择地区" forState:UIControlStateNormal];
    selectAddress.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [selectAddress setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [selectAddress addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [white addSubview:selectAddress];
    
    
    address = [[UITextView alloc]initWithFrame:CGRectMake(20,200, zScreenWidth-30, 80)];
    address.backgroundColor = [UIColor whiteColor];
    address.delegate = self;
    address.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    address.returnKeyType = UIReturnKeyDone;
    
    [white addSubview:address];
    
    pleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth-30, 30)];
    pleLab.numberOfLines = 0;
    pleLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    pleLab.text = @" 请填写您的详细地址";
    pleLab.textColor = [UIColor colorHexString:@"888888"];
    pleLab.textAlignment = NSTextAlignmentLeft;;
    [address addSubview:pleLab];
    
    adressButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 280+10, 130, 30)];
    adressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    adressButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    adressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [adressButton setTitle:@"  设为默认地址" forState:UIControlStateNormal];
    [adressButton setTitle:@"  默认地址" forState:UIControlStateSelected];
    [adressButton setImage:[UIImage imageNamed:@"icon_disagree"] forState:UIControlStateNormal];
    [adressButton setImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateSelected];
    [adressButton setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [adressButton setTitleColor:[UIColor colorHexString:@"fddc30"] forState:UIControlStateSelected];
    adressButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [adressButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [white addSubview:adressButton];
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-12-15, 100+19, 12, 12)];
    right.contentMode = UIViewContentModeCenter;
    right.image = [UIImage imageNamed:@"arrow"];
    [white addSubview:right];
    
    // Do any additional setup after loading the view.
}

- (void)select:(UIButton *)selectBtn{
    selectBtn.selected = !selectBtn.selected;
    
    if(selectBtn.selected == NO){
        
        typeStr = @"否";
        NSLog(@"%@",typeStr);

    }else{
        
        typeStr = @"是";
        NSLog(@"%@",typeStr);

    }
    
    
}

- (void)showRight:(UIButton *)sender{
    
    
    if (_dic.count>0) {
        if (name.text.length>0 && phoneNum.text.length>0 && addressstr.length>0 && address.text.length>0) {
            
            NSDictionary *dic = @{@"name":name.text,@"mobile":phoneNum.text,@"area":addressstr,@"address":address.text,@"type":typeStr,@"receiverId":[_dic objectForKey:@"receiverId"]};
            
            NSLog(@"%@",dic);
            
            [HTTPRequest postWithURL:@"api/memberaddress/modifyaddress" method:@"POST" params: dic ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"1111222===%@",json);
                
                self.callBackBlock(@"back");
                [self.navigationController popViewControllerAnimated:NO];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
    }else{
        if (name.text.length>0 && phoneNum.text.length>0 && addressstr.length>0 && address.text.length>0) {
            
            NSDictionary *dic = @{@"name":name.text,@"mobile":phoneNum.text,@"area":addressstr,@"address":address.text,@"type":typeStr};
            
            [HTTPRequest postWithURL:@"api/memberaddress/addnewaddress" method:@"POST" params: dic ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"1111222===%@",json);
                
                self.callBackBlock(@"back");
                [self.navigationController popViewControllerAnimated:NO];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
    }
    
    
    
    
    
    
}

- (void)selectAddress{
    [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:@"选择地址" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString * _Nullable address, NSString * _Nullable zipcode) {
        addressstr = address;
        [selectAddress setTitle:address forState:UIControlStateNormal];
    } cancelBlock:^{
        
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        pleLab.alpha = 1;
    } else {
        pleLab.alpha = 0;
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
