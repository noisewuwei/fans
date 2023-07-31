//
//  HeartViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "HeartViewController.h"
#import "FirstTableViewCell.h"
#import "GoodsDetailViewController.h"

@interface HeartViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSMutableArray *activityarr;
    NSDictionary *datadict;
    NSInteger page;
}

@end

@implementation HeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    
    activityarr = [NSMutableArray array];
    
    self.title = @"爱心";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    tableview.header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(load)];
    
    [self load];
    
    // Do any additional setup after loading the view.
}

- (void)load{
    [HTTPRequest postWithURL:@"api/activity/getlistbytype" method:@"POST" params: @{@"pageNum":@"0",@"pageSize":@"10",@"activityType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"first success%@",json);
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
        datadict = [dic objectForKey:@"data"];
        activityarr = [datadict objectForKey:@"list"];
        
        [tableview reloadData];
        [tableview.header endRefreshing];
        
        if ([[datadict objectForKey:@"total"] integerValue]>10) {
            tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoredata)];
        }
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)loadmoredata{
    {
        NSDictionary *param = @{@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":@10,@"activityType":@"0"};
        page++;
        [HTTPRequest postWithURL:@"yrycapi/signinrecord/getrecords" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            datadict = [dic objectForKey:@"data"];
            for (NSDictionary *dict in [datadict objectForKey:@"list"]) {
                [activityarr addObject:dict];
            }
            [tableview reloadData];
            [tableview.footer endRefreshing];
            
            if ([[datadict objectForKey:@"list"] count] == 0) {
                [tableview.footer endRefreshingWithNoMoreData];
            }
            
            NSLog(@"second%@",json);
            
            
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    NSDictionary *dict = activityarr[indexPath.row];
    
    [cell.headImg sd_setImageWithURL:[[dict objectForKey:@"club"] objectForKey:@"portrait"]];
    cell.titleLab.text = [[dict objectForKey:@"club"] objectForKey:@"name"];
    [cell.bigImg sd_setImageWithURL:[dict objectForKey:@"cover"]];
    cell.downLab.text = [dict objectForKey:@"name"];
    cell.moneyLab.text = [NSString stringWithFormat:@"¥%@-¥%@",[dict objectForKey:@"minMoney"],[dict objectForKey:@"maxMoney"]];
    
    NSString *str = [NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*100];
    
    cell.numLab.text = str;
    
    if ([[dict objectForKey:@"targetMoney"] intValue] == 0) {
        cell.line.hidden = YES;
    }else{
        cell.line.hidden = NO;
        cell.yellowView.frame = CGRectMake(0, 0, [[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*(zScreenWidth-30), 5);
    }
    [cell.line addSubview:cell.yellowView];
    
    cell.timeLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"endTimeForString"]];
    cell.soldLab.text = [NSString stringWithFormat:@"已售：%@",[dict objectForKey:@"soldNum"]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = activityarr[indexPath.row];
    GoodsDetailViewController *gvc = [[GoodsDetailViewController alloc]init];
    gvc.str = [dict objectForKey:@"activityId"];
    gvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gvc animated:YES];
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
