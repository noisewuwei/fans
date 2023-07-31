//
//  MyFocusViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MyFocusViewController.h"
#import "FansTeamListTableViewCell.h"

@interface MyFocusViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSMutableArray *btnarr;
    NSMutableArray *viewarr;
    NSString *typestr;
    
    NSArray *starlist;
}

@end

@implementation MyFocusViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typestr = @"1";
    
    [self createBarLeftWithImage:@"iconback"];
    self.title = @"关注";
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    
    [HTTPRequest postWithURL:@"api/member/attention/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSDictionary *dic = [json objectForKey:@"data"];
        
        starlist = [NSArray arrayWithArray:[dic objectForKey:@"list"]];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    // Do any additional setup after loading the view.

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return starlist.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
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
    
    NSArray *titleArr = @[@"明星",@"粉丝团"];
    
    btnarr = [NSMutableArray array];
    viewarr = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2*i, 0, zScreenWidth/2, 50)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btnarr addObject:btn];
        [downView addSubview:btn];
        
        UIView *yellow = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/2/2-20, 50-3, 40, 2)];
        yellow.backgroundColor = [UIColor colorHexString:@"fedb43"];
        yellow.tag = 200+i;
        [btn addSubview:yellow];
        
        [viewarr addObject:yellow];
        
        yellow.hidden = YES;
        
    }
    
    if ([typestr isEqualToString:@"1"]) {
        ((UIButton *)[btnarr objectAtIndex:0]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:0]).hidden=NO;
    }else{
        ((UIButton *)[btnarr objectAtIndex:1]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:1]).hidden=NO;
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
        
        [HTTPRequest postWithURL:@"api/member/attention/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSDictionary *dic = [json objectForKey:@"data"];
            
            starlist = [NSArray arrayWithArray:[dic objectForKey:@"list"]];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        
        typestr = @"2";
        [tableview reloadData];
        
        [HTTPRequest postWithURL:@"api/member/attention/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"relationType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSDictionary *dic = [json objectForKey:@"data"];
            
            starlist = [NSArray arrayWithArray:[dic objectForKey:@"list"]];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }
    
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FansTeamListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dic = starlist[indexPath.row];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FansTeamListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[dic objectForKey:@"portrait"]];
    cell.titLab.text = [dic objectForKey:@"name"];
    cell.contentLab.text = [NSString stringWithFormat:@"关注度：%@",[dic objectForKey:@"attentionNum"]];

    return cell;
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
