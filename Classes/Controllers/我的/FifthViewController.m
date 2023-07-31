//
//  FifthViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FifthViewController.h"
#import "MineTableViewCell.h"
#import "PersonalInfoViewController.h"
#import "PostAdviceViewController.h"
#import "MyFocusViewController.h"
#import "MyExpressionViewController.h"
#import "MyOrderListViewController.h"
#import "AddressListViewController.h"
#import "BuildTeamViewController.h"

@interface FifthViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    UIView *white;
    NSDictionary *dic;
}

@end

@implementation FifthViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";

    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, zScreenWidth, zScreenHeight+20-zToolBarHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    tableview.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    
    [self.view addSubview:tableview];
    
    [HTTPRequest postWithURL:@"api/member/getNew" method:@"POST" params:nil ProgressHUD:self.Hud  controller:self response:^(id json) {
        
        dic = [json objectForKey:@"data"];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        
    }];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
    
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 180+85;
    }
    
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 180+85)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, -500, zScreenWidth, 180+500)];
    top.backgroundColor = [UIColor colorHexString:@"fedb43"];
    [back addSubview:top];
    
    white = [[UIView alloc]initWithFrame:CGRectMake(15, 180-85, zScreenWidth-30, 170)];
    white.backgroundColor = [UIColor colorHexString:@"ffffff"];
    white.layer.masksToBounds = NO;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:white.bounds];
    white.layer.cornerRadius = 5;
    white.layer.shadowOffset = CGSizeMake(0, 5);
    white.layer.shadowOpacity = 0.3f;
    white.layer.shadowPath = shadowPath.CGPath;
    white.layer.shadowColor = [[UIColor colorHexString:@"9BA2AF"] CGColor];
    [back addSubview:white];
    
    
    UIButton *headImg = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-30, 180-85-30, 60, 60)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 30;
    headImg.layer.borderWidth = 2;
    headImg.layer.borderColor = [[UIColor colorHexString:@"fedb43"]CGColor];
    [headImg setBackgroundColor:[UIColor blackColor]];
    [headImg addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    
    [headImg sd_setImageWithURL:[dic objectForKey:@"portrait"] forState:UIControlStateNormal];

    [back addSubview:headImg];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-30)/2-50, 30+5, 100, 20)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    nameLab.textColor = [UIColor colorHexString:@"383838"];
    nameLab.text = [dic objectForKey:@"nickname"];
    [white addSubview:nameLab];
    
    UILabel *sloganLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30+5+20, zScreenWidth-30, 20)];
    sloganLab.textAlignment = NSTextAlignmentCenter;
    sloganLab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    sloganLab.textColor = [UIColor colorHexString:@"777777"];
    sloganLab.text = [dic objectForKey:@"motto"];
    [white addSubview:sloganLab];
    
    
    NSArray *namearr = @[@"关注",@"订单",@"表情",@"服务"];
    NSArray *imgarr = @[@"icon-focus",@"icon-check",@"icon-smile",@"icon-service"];
    
    for (int i = 0; i < 4; i++) {
        [self creatBtn:namearr[i] withimgurl:imgarr[i] andframe:CGRectMake((zScreenWidth-30)/4*i, 30+5+20+20+20, (zScreenWidth-30)/4, 78) andtag:112+i];
    }
    
    
    
    
    
    
    return headerView;
}

- (void)jump{
    PersonalInfoViewController *pvc = [[PersonalInfoViewController alloc]init];
    pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pvc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    NSArray *img1 = @[@"icon-team",@"icon-dress"];
    NSArray *title1 = @[@"我要建团",@"收货地址"];
    
    NSArray *img2 = @[@"icon-kfu",@"icon-feedback",@"icon-set"];
    NSArray *title2 = @[@"客服中心",@"意见反馈",@"设置"];
    
    if (indexPath.section == 0) {
        cell.headImg.image = [UIImage imageNamed:img1[indexPath.row]];
        cell.nameLab.text = title1[indexPath.row];
    }else{
        cell.headImg.image = [UIImage imageNamed:img2[indexPath.row]];
        cell.nameLab.text = title2[indexPath.row];
    }
    
    
    
    return cell;
}

- (void)creatBtn:(NSString *)title withimgurl:(NSString *)url andframe:(CGRect)frame andtag:(int)i{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.tag = i;
    [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-15, 0, 30, 30)];
    image.image = [UIImage imageNamed:url];
    [btn addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-25, 35, 50, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorHexString:@"383838"];
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    label.text = title;
    [btn addSubview:label];
    
    [white addSubview:btn];
    
}

- (void)jump:(UIButton *)sender{
    if (sender.tag == 112) {
        MyFocusViewController *mvc = [[MyFocusViewController alloc]init];
        mvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mvc animated:YES];
    }else if (sender.tag == 114){
        MyExpressionViewController *mvc = [[MyExpressionViewController alloc]init];
        mvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mvc animated:YES];
    }else if(sender.tag == 113){
        MyOrderListViewController *mvc = [[MyOrderListViewController alloc]init];
        mvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mvc animated:YES];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            
            PostAdviceViewController *pvc = [[PostAdviceViewController alloc]init];
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pvc animated:YES];
        
        }else if (indexPath.row == 2){
            
            PersonalInfoViewController *pvc = [[PersonalInfoViewController alloc]init];
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pvc animated:YES];
            
        }
    }else{
        if (indexPath.row == 1) {
            
            AddressListViewController *avc = [[AddressListViewController alloc]init];
            avc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:avc animated:YES];
            
        }else{
            BuildTeamViewController *bvc = [[BuildTeamViewController alloc]init];
            bvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }
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
