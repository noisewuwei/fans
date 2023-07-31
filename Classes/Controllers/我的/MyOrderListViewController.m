//
//  MyOrderListViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "MyOrderListTableViewCell.h"
#import "OrderDetailViewController.h"
#import "MPSPayManager.h"

@interface MyOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSMutableArray *btnarr;
    NSMutableArray *viewarr;
    NSString *typestr;
    
    NSArray *dataarr;
}

@end

@implementation MyOrderListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typestr = @"1";
    
    self.title = @"我的订单";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    [HTTPRequest postWithURL:@"api/order/showorderlist" method:@"POST" params: @{@"type":@"全部"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"1111222===%@",json);
        
        dataarr = [json objectForKey:@"data"];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 266+10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 50)];
    downView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:downView];
    
    NSArray *titleArr = @[@"全部",@"已支付",@"待支付",@"失效"];
    
    btnarr = [NSMutableArray array];
    viewarr = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/3*i, 0, zScreenWidth/3, 50)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btnarr addObject:btn];
        [downView addSubview:btn];
        
        UIView *yellow = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/3/2-20, 50-3, 40, 2)];
        yellow.backgroundColor = [UIColor colorHexString:@"fedb43"];
        yellow.tag = 200+i;
        [btn addSubview:yellow];
        
        [viewarr addObject:yellow];
        
        yellow.hidden = YES;
        
    }
    
    if ([typestr isEqualToString:@"1"]) {
        ((UIButton *)[btnarr objectAtIndex:0]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:0]).hidden=NO;
    }else if ([typestr isEqualToString:@"2"]){
        ((UIButton *)[btnarr objectAtIndex:1]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:1]).hidden=NO;
    }else if ([typestr isEqualToString:@"3"]){
        ((UIButton *)[btnarr objectAtIndex:2]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:2]).hidden=NO;
    }else{
        ((UIButton *)[btnarr objectAtIndex:3]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:3]).hidden=NO;
    }
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, zScreenWidth, 1)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [downView addSubview:line];
    
    return headerView;
}


- (void)click:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
        UIView *yellow = (UIView *)[[sender superview]viewWithTag:200 + i];
        yellow.hidden = YES;
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        
        typestr = @"1";
        [tableview reloadData];
        
        [HTTPRequest postWithURL:@"api/order/showorderlist" method:@"POST" params: @{@"type":@"全部"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"1111222===%@",json);
            
            dataarr = [json objectForKey:@"data"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else if (sender.tag == 101){
        typestr = @"2";
        [tableview reloadData];
        
        [HTTPRequest postWithURL:@"api/order/showorderlist" method:@"POST" params: @{@"type":@"已支付"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"1111222===%@",json);
            
            dataarr = [json objectForKey:@"data"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else if (sender.tag == 102){
        typestr = @"3";
        [tableview reloadData];
        
        [HTTPRequest postWithURL:@"api/order/showorderlist" method:@"POST" params: @{@"type":@"待支付"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"1111222===%@",json);
            
            dataarr = [json objectForKey:@"data"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        
        typestr = @"4";
        [tableview reloadData];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    MyOrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dic = dataarr[indexPath.row];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[MyOrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.title.text = [dic objectForKey:@"title"];
    [cell.bigImg sd_setImageWithURL:[dic objectForKey:@"img"]];
    cell.name.text = [dic objectForKey:@"name"];
    cell.type.text = [dic objectForKey:@"productName"];
    cell.money.text = [NSString stringWithFormat:@"价格：¥ %@",[dic objectForKey:@"price"]];
    cell.number.text = [dic objectForKey:@"count"];
    cell.totalmoney.text = [NSString stringWithFormat:@"价格：¥ %@",[dic objectForKey:@"totalprice"]];
    cell.status.text = [dic objectForKey:@"status"];
    
    if ([[dic objectForKey:@"status"] isEqualToString:@"未支付"]) {
        [cell.pay setTitle:@"支付" forState:UIControlStateNormal];
        [cell.pay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.pay setTitle:@"查看订单" forState:UIControlStateNormal];
        [cell.pay addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.pay.tag = indexPath.row;
    
    return cell;
}

- (void)pay:(UIButton *)sender{
    
    NSDictionary *dic = dataarr[sender.tag];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"选择付款方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"微信支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
        MPSChannel channel = MPSChannelWeChat;
        [[MPSPayManager defaultManager] payWithPrice:[[dic objectForKey:@"totalprice"] floatValue]*100 channel:channel withId:[dic objectForKey:@"orderId"]];
        
        
        
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        NSArray *channels = @[@(MPSChannelAliPay),@(MPSChannelWeChat),@(MPSChannelUnionPay),@(MPSChannelApplePay)];
        MPSChannel channel = MPSChannelAliPay;
        [[MPSPayManager defaultManager] payWithPrice:[[dic objectForKey:@"totalprice"] floatValue]*100 channel:channel withId:[dic objectForKey:@"orderId"]];
        
        
        
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
       

- (void)check:(UIButton *)sender{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = dataarr[indexPath.row];
    OrderDetailViewController *ovc = [[OrderDetailViewController alloc]init];
    ovc.orderid = [dic objectForKey:@"orderId"];
    [self.navigationController pushViewController:ovc animated:YES];
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
