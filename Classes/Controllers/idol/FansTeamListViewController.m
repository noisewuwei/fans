//
//  FansTeamListViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/25.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FansTeamListViewController.h"
#import "FansTeamListTableViewCell.h"
#import "FansTeamDetailViewController.h"

@interface FansTeamListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tableview;
    NSArray *dataarr;
}

@end

@implementation FansTeamListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/club/getstarclub" method:@"POST" params: @{@"starId":_starid} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        dataarr = [json objectForKey:@"data"];
        
        NSLog(@"list%@",json);
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"粉丝团";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FansTeamListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dic = dataarr[indexPath.row];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FansTeamListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[dic objectForKey:@"portrait"]];
    cell.titLab.text = [dic objectForKey:@"name"];
    cell.contentLab.text = [dic objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = dataarr[indexPath.row];
    
    FansTeamDetailViewController *fvc = [[FansTeamDetailViewController alloc]init];
    
    fvc.FTid = [dic objectForKey:@"clubId"];
    
    [self.navigationController pushViewController:fvc animated:YES];
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
