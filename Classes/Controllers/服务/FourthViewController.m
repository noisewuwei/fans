//
//  FourthViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FourthViewController.h"
#import "FirstTableViewCell.h"
#import "DesginDetailWebViewController.h"

@interface FourthViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField *search;
    UITableView *tableview;
    UIView *back;
    NSArray *dataarr;
    UIView *topback;
}

@end

@implementation FourthViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    topback.hidden = NO;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"服务";
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    topback = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 40)];
    topback.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar addSubview:topback];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(5.5, 5.5, zScreenWidth-11, 29)];
    whiteback.backgroundColor = [UIColor colorHexString:@"ececec"];
    whiteback.layer.masksToBounds = YES;
    whiteback.layer.cornerRadius = 14.5;
    [topback addSubview:whiteback];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(11, 4.5, 20, 20)];
    searchImg.image = [UIImage imageNamed:@"icon_search"];
    [whiteback addSubview:searchImg];
    
    search = [[UITextField alloc]initWithFrame:CGRectMake(11+20+10, 0, zScreenWidth-80, 29)];
    search.placeholder = @"请输入作品关键词、明星或达人昵称";
    search.returnKeyType = UIReturnKeyDone;
    search.delegate = self;
    search.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [whiteback addSubview:search];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    [self load:@"设计"];
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 391;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 157;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 157)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 147, zScreenWidth, 10)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line];
    
    NSArray *namearr = @[@"设计",@"生产",@"广告",@"会展"];
    NSArray *imgarr = @[@"icon-design",@"icon-produce",@"icon-ad",@"icon-show"];
    
    for (int i = 0; i < 4; i++) {
        [self creatBtn:namearr[i] withimgurl:imgarr[i] andframe:CGRectMake(zScreenWidth/4*i, 10, zScreenWidth/4, 78) andtag:112+i];
    }
    
    NSArray *namearr2 = @[@"影院",@"网站",@"app",@"其他"];
    NSArray *imgarr2 = @[@"icon-movie",@"icon-web",@"icon-app",@"icon-more"];
    
    for (int i = 0; i < 4; i++) {
        [self creatBtn:namearr2[i] withimgurl:imgarr2[i] andframe:CGRectMake(zScreenWidth/4*i, 78+10, zScreenWidth/4, 78) andtag:116+i];
    }
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSDictionary *dict = dataarr[indexPath.row];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    cell.line.hidden = YES;
    
    [cell.rightBtn setTitle:@"详情" forState:UIControlStateNormal];
    
    [cell.headImg sd_setImageWithURL:[[dict objectForKey:@"serveAuthor"] objectForKey:@"portrait"]];
    cell.titleLab.text = [[dict objectForKey:@"serveAuthor"] objectForKey:@"name"];
    [cell.bigImg sd_setImageWithURL:[dict objectForKey:@"cover"]];
    cell.downLab.text = [dict objectForKey:@"name"];
    cell.moneyLab.text = [NSString stringWithFormat:@"¥%@",[dict objectForKey:@"price"]];
    cell.soldLab.text = [NSString stringWithFormat:@"已售：%@",[dict objectForKey:@"soldNum"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    topback.hidden = YES;
    
    NSDictionary *dict = dataarr[indexPath.row];
    
    DesginDetailWebViewController *dvc = [[DesginDetailWebViewController alloc]init];
    
    dvc.str = [dict objectForKey:@"serveId"];
    
    dvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:dvc animated:YES];
    
    
    
}

- (void)load:(NSString *)str{
    [HTTPRequest postWithURL:@"api/serve/getservicelist" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"optionName":str} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"1111222===%@",json);
        
        dataarr = [[json objectForKey:@"data"] objectForKey:@"list"];
        
        [tableview reloadData];
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [search resignFirstResponder];
    }
    return YES;
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
    
    [back addSubview:btn];
    
}
- (void)jump:(UIButton *)sender{
    if (sender.tag == 112) {
        
        [self load:@"设计"];
    
    }else if (sender.tag == 113){
        
        [self load:@"生产"];
        
    }else if (sender.tag == 114){
        
        [self load:@"广告"];
        
    }else if (sender.tag == 115){
        
        [self load:@"会展"];
        
    }else if (sender.tag == 116){
        
        [self load:@"影院"];
        
    }else if (sender.tag == 117){
        
        [self load:@"网站"];
        
    }else if (sender.tag == 118){
        
        [self load:@"app"];
        
    }else if (sender.tag == 119){
        
        [self load:@"其他"];
        
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
