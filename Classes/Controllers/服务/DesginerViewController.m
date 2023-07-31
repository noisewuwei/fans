//
//  DesginerViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/30.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "DesginerViewController.h"
#import "DesignerTableViewCell.h"

@interface DesginerViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
}

@end

@implementation DesginerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设计师";
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
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
    return 270;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 218;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 218)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 140)];
    image.contentMode = UIViewContentModeCenter;
    image.backgroundColor = [UIColor blueColor];
    [back addSubview:image];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 140-35, 70, 70)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 35;
    headImg.layer.borderWidth = 2;
    headImg.layer.borderColor = [[UIColor colorHexString:@"fedb43"]CGColor];
    headImg.backgroundColor = [UIColor yellowColor];
    [back addSubview:headImg];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+70+10, 140-15, zScreenWidth-120, 30)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    nameLabel.textColor = [UIColor colorHexString:@"383838"];
    nameLabel.text = @"设计师";
    [back addSubview:nameLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+70+10, 140+15, zScreenWidth-120, 20)];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
    contentLabel.textColor = [UIColor colorHexString:@"777777"];
    contentLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    [back addSubview:contentLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 140+68, zScreenWidth, 10)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    DesignerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[DesignerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.headImg.backgroundColor = [UIColor blackColor];
    cell.nameLab.text = @"设计师";
    cell.timeLab.text = @"12-12";
    cell.infoLab.text = @"哈哈哈哈哈哈";
    cell.bigImg.backgroundColor = [UIColor blackColor];
    
    
    
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
