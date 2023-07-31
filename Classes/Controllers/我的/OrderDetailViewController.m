//
//  OrderDetailViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/7.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@property(nonatomic,strong) UIImageView *bigImg;
@property(nonatomic,strong) UILabel *ordertitle;
@property(nonatomic,strong) UILabel *status;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *type;
@property(nonatomic,strong) UILabel *money;
@property(nonatomic,strong) UILabel *number;
@property(nonatomic,strong) UILabel *totalmoney;
@property(nonatomic,strong) UILabel *orderno;
@property(nonatomic,strong) UILabel *ordertime;
@property(nonatomic,strong) UILabel *username;
@property(nonatomic,strong) UILabel *usernum;
@property(nonatomic,strong) UILabel *useraddress;

@end

@implementation OrderDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/order/showorderdetailsbyid" method:@"POST" params: @{@"orderId":_orderid} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"1111222===%@",json);
        
        NSDictionary *dic = [json objectForKey:@"data"];
        
        _ordertitle.text = [dic objectForKey:@"title"];
        _status.text = [dic objectForKey:@"status"];
        [_bigImg sd_setImageWithURL:[dic objectForKey:@"img"]];
        _name.text = [dic objectForKey:@"name"];
        _type.text = [dic objectForKey:@"productName"];
        _money.text = [NSString stringWithFormat:@"价格：¥ %@",[dic objectForKey:@"price"]];
        _number.text = [NSString stringWithFormat:@"数量：¥ %@",[dic objectForKey:@"count"]];
        _orderno.text = [NSString stringWithFormat:@"订单编号：¥ %@",[dic objectForKey:@"code"]];
        _ordertime.text = [NSString stringWithFormat:@"下单时间：¥ %@",[dic objectForKey:@"payTime"]];
        _username.text = [dic objectForKey:@"reName"];
        _usernum.text = [dic objectForKey:@"reMobile"];
        _useraddress.text = [dic objectForKey:@"address"];
        _totalmoney.text = [NSString stringWithFormat:@"总价：¥ %@",[dic objectForKey:@"totalprice"]];
        
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    back.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:back];
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, 390)];
    white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:white];
    
    UIView *center = [[UIView alloc]initWithFrame:CGRectMake(0, 40, zScreenWidth, 126)];
    center.backgroundColor = [UIColor colorHexString:@"fcfcfc"];
    [white addSubview:center];
    
    _ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 250, 20)];
    _ordertitle.textAlignment = NSTextAlignmentLeft;
    _ordertitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _ordertitle.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_ordertitle];
    
    _status = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-80-15, 10, 80, 20)];
    _status.textAlignment = NSTextAlignmentRight;
    _status.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _status.textColor = [UIColor colorHexString:@"fd7e82"];
    [white addSubview:_status];
    
    _bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40+12, 100, 100)];
    _bigImg.contentMode = UIViewContentModeScaleToFill;
    [white addSubview:_bigImg];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12, 250, 20)];
    _name.textAlignment = NSTextAlignmentLeft;
    _name.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    _name.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_name];
    
    _type = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12+20+10, 80, 20)];
    _type.textAlignment = NSTextAlignmentLeft;
    _type.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    _type.textColor = [UIColor colorHexString:@"777777"];
    [white addSubview:_type];
    
    _money = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12+100-20, 80, 20)];
    _money.textAlignment = NSTextAlignmentLeft;
    _money.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    _money.textColor = [UIColor colorHexString:@"777777"];
    [white addSubview:_money];
    
    _number = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-80-15, 40+12+100-20, 80, 20)];
    _number.textAlignment = NSTextAlignmentRight;
    _number.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    _number.textColor = [UIColor colorHexString:@"777777"];
    [white addSubview:_number];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40+126+50, zScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [white addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40+126+50*2, zScreenWidth, 1)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [white addSubview:line2];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 40+126+50*2+74, zScreenWidth, 1)];
    line3.backgroundColor = [UIColor colorHexString:@"ececec"];
    [white addSubview:line3];
    
    _orderno = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+126+15, 250, 20)];
    _orderno.textAlignment = NSTextAlignmentLeft;
    _orderno.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _orderno.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_orderno];
    
    _ordertime = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+126+50+15, 250, 20)];
    _ordertime.textAlignment = NSTextAlignmentLeft;
    _ordertime.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _ordertime.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_ordertime];
    
    _username = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+126+50*2+10, 100, 20)];
    _username.textAlignment = NSTextAlignmentLeft;
    _username.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _username.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_username];
    
    _usernum = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-150, 40+126+50*2+10, 150, 20)];
    _usernum.textAlignment = NSTextAlignmentRight;
    _usernum.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _usernum.textColor = [UIColor colorHexString:@"383838"];
    [white addSubview:_usernum];
    
    _useraddress = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+126+50*2+10+20,zScreenWidth-30, 40)];
    _useraddress.textAlignment = NSTextAlignmentLeft;
    _useraddress.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _useraddress.textColor = [UIColor colorHexString:@"383838"];
    _useraddress.numberOfLines = 0;
    [white addSubview:_useraddress];
    
    
    
    _totalmoney = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-100-15, 40+126+50*2+74+15, 100, 20)];
    _totalmoney.textAlignment = NSTextAlignmentRight;
    _totalmoney.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    _totalmoney.textColor = [UIColor colorHexString:@"fd7e82"];
    [white addSubview:_totalmoney];
    
    
    
    _ordertitle.text = @"商品名称";
    _status.text = @"已完成";
    _name.text = @"生日商品";
    _type.text = @"类型：类型1";
    _money.text = @"价格：¥129";
    _number.text = @"数量：1";
    _orderno.text = @"订单编号：29191919";
    _ordertime.text = @"下单时间：2017-09-08";
    _username.text = @"詹姆斯";
    _usernum.text = @"13101899999";
    _useraddress.text = @"南通产业技术研究院";
    _totalmoney.text = @"129";
    
    
    
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
