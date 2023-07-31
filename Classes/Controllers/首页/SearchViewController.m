//
//  SearchViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField *search;
    UITableView *tableview;
    UIButton *Btn;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.title = @"明星搜索";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor colorHexString:@"ececec"];
    
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
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40+50+86+10+50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 40+50+86+10+50)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIView *topback = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 40)];
    topback.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:topback];
    
    UIView *whiteback = [[UIView alloc]initWithFrame:CGRectMake(5.5, 5.5, zScreenWidth-11, 29)];
    whiteback.backgroundColor = [UIColor whiteColor];
    whiteback.layer.masksToBounds = YES;
    whiteback.layer.cornerRadius = 14.5;
    [topback addSubview:whiteback];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(11, 4.5, 20, 20)];
    searchImg.image = [UIImage imageNamed:@"icon_search"];
    [whiteback addSubview:searchImg];
    
    search = [[UITextField alloc]initWithFrame:CGRectMake(11+20+10, 0, zScreenWidth-80, 29)];
    search.placeholder = @"明星搜索";
    search.returnKeyType = UIReturnKeyDone;
    search.delegate = self;
    search.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [whiteback addSubview:search];
    
    UILabel *bigLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 40+10, 50, 30)];
    bigLab.textAlignment = NSTextAlignmentLeft;
    bigLab.textColor = [UIColor colorHexString:@"383838"];
    bigLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    bigLab.text = @"热门";
    [headerView addSubview:bigLab];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40+50, zScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line1];
    
    
    NSArray *arr1 = @[@"test1",@"test2",@"test3",@"test4"];
    NSArray *arr2 = @[@"test5",@"test6",@"test7",@"test8"];
    
    for (int i = 0; i<4; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(10+(10+(zScreenWidth-50)/4)*i, line1.frame.origin.y+10, (zScreenWidth-50)/4, 28)];
        Btn.layer.masksToBounds = YES;
        Btn.layer.cornerRadius = 14;
        [Btn setTitle:arr1[i] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];       Btn.layer.borderWidth = 1;
        Btn.layer.borderColor= [[UIColor colorHexString:@"c7c7c7"]CGColor];
        
        Btn.selected = NO;
        Btn.tag = 100+i;
        
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:Btn];
    }
    
    for (int i = 0; i<4; i++) {
        Btn = [[UIButton alloc]initWithFrame:CGRectMake(10+(10+(zScreenWidth-50)/4)*i, line1.frame.origin.y+10+28+10, (zScreenWidth-50)/4, 28)];
        Btn.layer.masksToBounds = YES;
        Btn.layer.cornerRadius = 14;
        [Btn setTitle:arr2[i] forState:UIControlStateNormal];
        Btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [Btn setBackgroundColor:[UIColor whiteColor]];
        [Btn setTitleColor:[UIColor colorHexString:@"888888"] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];       Btn.layer.borderWidth = 1;
        Btn.layer.borderColor= [[UIColor colorHexString:@"c7c7c7"]CGColor];
        
        Btn.selected = NO;
        Btn.tag = 104+i;
        
        [Btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:Btn];
    }
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y+86, zScreenWidth, 10)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line2];
    
    UILabel *secondLab = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.frame.origin.y+10+10, 100, 30)];
    secondLab.textAlignment = NSTextAlignmentLeft;
    secondLab.textColor = [UIColor colorHexString:@"383838"];
    secondLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    secondLab.text = @"搜索历史";
    [headerView addSubview:secondLab];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y+49+10, zScreenWidth, 1)];
    line3.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line3];
    
    return headerView;
}


- (void)choose:(UIButton *)sender{
    

    
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    cell.textLabel.textColor = [UIColor colorHexString:@"777777"];
    cell.textLabel.text = @"lalalala";
    
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [search resignFirstResponder];
        SearchResultViewController *svc = [[SearchResultViewController alloc]init];
        [self.navigationController pushViewController:svc animated:YES];
    }
    return YES;
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
