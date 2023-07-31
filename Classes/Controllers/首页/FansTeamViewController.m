//
//  FansTeamViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FansTeamViewController.h"
#import "FirstTableViewCell.h"

@interface FansTeamViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
}

@end

@implementation FansTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-49) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    
    cell.headImg.backgroundColor = [UIColor blueColor];
    cell.titleLab.text = @"朴灿烈的官方粉丝团";
    cell.bigImg.backgroundColor = [UIColor redColor];
    cell.downLab.text = @"朴灿烈生日应援活动";
    cell.moneyLab.text = @"¥8-14";
    cell.numLab.text = @"50%";
    cell.timeLab.text = @"2017-12-09截止";
    cell.soldLab.text = @"已售：23";
    
    
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
