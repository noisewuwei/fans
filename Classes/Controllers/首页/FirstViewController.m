//
//  FirstViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FirstViewController.h"
#import "SDCycleScrollView.h"
#import "FirstTableViewCell.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
#import "SupportContentViewController.h"
#import "SupportViewController.h"
#import "GoodsViewController.h"
#import "HeartViewController.h"
#import "VoteViewController.h"
#import "ActivityDetailViewController.h"
#import "VoteDetailViewController.h"
#import "GoodsDetailViewController.h"
#import "HeartDetailViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>{
    UITableView *tableview;
    NSDictionary *datadict;
    NSArray *adarr;
    NSArray *activityarr;
    NSInteger page;
}

@end

@implementation FirstViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    self.title = @"首页";
    [self createBarLeftWithImage:@"icon_sign"];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];

    tableview.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(load)];
    
    [self createBarRightWithImage:@"icon_topbar_search"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load) name:@"changeinfo" object:nil];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)load{
    [HTTPRequest postWithURL:@"api/club/gethomelist" method:@"POST" params: @{@"adPosition":@"AD_000001"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"first success%@",json);
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
        datadict = [dic objectForKey:@"data"];
        adarr = [datadict objectForKey:@"adList"];
        activityarr = [datadict objectForKey:@"activityList"];
        
        [tableview reloadData];
        [tableview.header endRefreshing];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return activityarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 391;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 254;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 244)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 244, zScreenWidth, 10)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line];
    
    
    if (adarr.count>0) {
        NSArray *imageNames = @[[adarr[0] objectForKey:@"image"],[adarr[1] objectForKey:@"image"],[adarr[2] objectForKey:@"image"]];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, zScreenWidth, 140) delegate:self placeholderImage:nil];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        
        cycleScrollView.imageURLStringsGroup = imageNames;
        
        cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        cycleScrollView.autoScrollTimeInterval = 3.0;
        [headerView addSubview:cycleScrollView];
        
    }
    
   
    
    NSArray *Imgarr = @[@"home_menu_1",@"home_menu_2",@"home_menu_3",@"home_menu_4"];
    NSArray *Titlearr = @[@"应援",@"商品",@"爱心",@"投票"];
    
    for (int i=0; i<4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0+(zScreenWidth/4)*i, 140, zScreenWidth/4, 104)];
        button.tag = i;
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(button.frame.size.width/2-21.5, 14, 50, 50)];
        imageview.image = [UIImage imageNamed:Imgarr[i]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(button.frame.size.width/2-21.5, 14+50+8, 50, 18)];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 9;
        label.backgroundColor = [UIColor colorHexString:@"FBDE6A"];
        label.text = Titlearr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        
        [button addSubview:imageview];
        [button addSubview:label];
        
        [button addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:button];
    }
    

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dict = activityarr[indexPath.row];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    
    
    [cell.headImg sd_setImageWithURL:[dict objectForKey:@"clubCover"]];
    cell.titleLab.text = [dict objectForKey:@"clubName"];
    [cell.bigImg sd_setImageWithURL:[dict objectForKey:@"cover"]];
    cell.downLab.text = [dict objectForKey:@"name"];
    cell.moneyLab.text = [NSString stringWithFormat:@"¥%@-¥%@",[dict objectForKey:@"minMoney"],[dict objectForKey:@"maxMoney"]];
    
    
    if ([[dict objectForKey:@"activityType"] intValue] == 4){
        
        cell.line.hidden = YES;
        
        
        
    }else{
        NSString *str = [NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*100];
        
        cell.numLab.text = str;
        
        if ([[dict objectForKey:@"targetMoney"] intValue] == 0) {
            cell.line.hidden = YES;
        }else{
            cell.line.hidden = NO;
            cell.yellowView.frame = CGRectMake(0, 0, [[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*(zScreenWidth-30), 5);
        }
        
        [cell.line addSubview:cell.yellowView];
    }
    
    
    cell.timeLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"endTimeForString"]];
    cell.soldLab.text = [NSString stringWithFormat:@"已完成：%@",[dict objectForKey:@"soldNum"]];
    
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = activityarr[indexPath.row];
    
    if ([[dict objectForKey:@"activityType"] intValue] == 0) {
        ActivityDetailViewController *avc = [[ActivityDetailViewController alloc]init];
        avc.str = [dict objectForKey:@"activityId"];
        avc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:avc animated:YES];
    }else if ([[dict objectForKey:@"activityType"] intValue] == 4){
        VoteDetailViewController *vvc = [[VoteDetailViewController alloc]init];
        vvc.str = [dict objectForKey:@"activityId"];
        vvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vvc animated:YES];
    }else if ([[dict objectForKey:@"activityType"] intValue] == 2){
        GoodsDetailViewController *gvc = [[GoodsDetailViewController alloc]init];
        gvc.str = [dict objectForKey:@"activityId"];
        gvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gvc animated:YES];
    }else{
        HeartDetailViewController *hvc = [[HeartDetailViewController alloc]init];
        hvc.str = [dict objectForKey:@"activityId"];
        hvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hvc animated:YES];
    }
    
}

- (void)showLeft:(UIButton *)sender{
    NSLog(@"left");
}

- (void)showRight:(UIButton *)sender{
    NSLog(@"right");
    SearchViewController *svc = [[SearchViewController alloc]init];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (void)jump:(UIButton *)sender{
    if (sender.tag == 0) {
        NSLog(@"0");
        SupportViewController *svc = [[SupportViewController alloc]init];
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }else if(sender.tag == 1) {
        NSLog(@"1");
        GoodsViewController *gvc = [[GoodsViewController alloc]init];
        gvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gvc animated:YES];
    }else if(sender.tag == 2) {
        NSLog(@"2");
        HeartViewController *hvc = [[HeartViewController alloc]init];
        hvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hvc animated:YES];
    }else{
        NSLog(@"3");
        VoteViewController *vvc = [[VoteViewController alloc]init];
        vvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vvc animated:YES];
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
