//
//  ExpressionListViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ExpressionListViewController.h"
#import "ExpressionListTableViewCell.h"
#import "ExpressionDetailViewController.h"

@interface ExpressionListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *dataarr;
}
@end

@implementation ExpressionListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/star/picture/getpicturelistbytype" method:@"POST" params: @{@"starId":_starid,@"type":@"2"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        dataarr = [json objectForKey:@"data"];
        
        NSLog(@"list%@",json);
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"表情";
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
    return 50+90+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ExpressionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dic = dataarr[indexPath.row];
    NSArray *arr = [dic objectForKey:@"starPictureInfo"];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[ExpressionListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[dic objectForKey:@"cover"]];
    cell.titLab.text = [dic objectForKey:@"name"];
    [cell.Img1 sd_setImageWithURL:[arr[0] objectForKey:@"image"]];
    [cell.Img2 sd_setImageWithURL:[arr[1] objectForKey:@"image"]];
    [cell.Img3 sd_setImageWithURL:[arr[2] objectForKey:@"image"]];
    [cell.Img4 sd_setImageWithURL:[arr[3] objectForKey:@"image"]];
    
    [cell.Btn setTitle:@"下载" forState:UIControlStateNormal];
    [cell.Btn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = dataarr[indexPath.row];
    
    ExpressionDetailViewController *evc = [[ExpressionDetailViewController alloc]init];
    
    evc.expressid = [dic objectForKey:@"pictureId"];
    
    [self.navigationController pushViewController:evc animated:YES];
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
