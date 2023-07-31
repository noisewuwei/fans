//
//  RankViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/9.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "RankViewController.h"
#import "SupportContentTableViewCell.h"

@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
}

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排行榜";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    SupportContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[SupportContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.firstImg.backgroundColor = [UIColor blackColor];
    cell.secondImg.backgroundColor = [UIColor blackColor];
    cell.name.text = @"name";
    cell.money.text = @"¥123";
    
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
