//
//  SelectIdolViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SelectIdolViewController.h"
#import "IdolListTableViewCell.h"
#import "ApplyIdolViewController.h"

@interface SelectIdolViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITableView *tableview;
    NSMutableArray *btnarr;
    NSMutableArray *viewarr;
    UIView *backview;
    NSString *typeStr;
    UITextField *search;
    
    UIView *downView;
    UIScrollView *scrollView;
    
    NSMutableArray *dataarray;
    
    NSArray *imgarr;
    
    UIView *nothingView;
    
    NSArray *hy;
    NSArray *rh;
    NSArray *om;
    
    NSDictionary *datadic;
}

@end

@implementation SelectIdolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgarr = @[@"chose_list_bjt100x100",@"chose_list_lyf100x100",@"chose_list_pcl100x100",@"chose_list_xhjy100x100",@"chose_list_yy100x100",@"icon_ad120x120"];
    
    dataarray = [NSMutableArray array];
    
    typeStr = @"1";
    
    self.title = @"选择明星";
    [self createBarLeftWithImage:@"iconback"];
    
//    [self createRightTitle:@"完成" titleColor:[UIColor blackColor]];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    downView = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-60, zScreenWidth,60)];
    downView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:downView];
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 1, zScreenWidth, 60)];
    scrollView.contentSize = CGSizeMake(zScreenWidth*2, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [downView addSubview:scrollView];

    nothingView = [[UIView alloc]initWithFrame:tableview.frame];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-80, 40, 160, 120)];
    image.contentMode = UIViewContentModeCenter;
    image.image = [UIImage imageNamed:@"icon-320x240"];
    [nothingView addSubview:image];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-80, 40+120+20, 160, 30)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor colorHexString:@"383838"];
    tipLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    tipLabel.text = @"这个明星还没有入驻";
    [nothingView addSubview:tipLabel];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-137.5, 40+120+20+30+50, 275, 40)];
    done.layer.masksToBounds = YES;
    done.layer.cornerRadius = 20;
    done.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [done setTitle:@"填写资料" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [done setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [done addTarget:search action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
    [nothingView addSubview:done];
    
    [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSLog(@"list%@",json);
        
        hy = [[json objectForKey:@"data"] objectForKey:@"list"];
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)showLeft:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    self.callBackBlock(@"back");
}

- (void)apply{
    ApplyIdolViewController *avc = [[ApplyIdolViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 91;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 90)];
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
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
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, zScreenWidth, 50)];
    downView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:downView];
    
    NSArray *titleArr = @[@"华语",@"日韩",@"欧美"];
    
    btnarr = [NSMutableArray array];
    viewarr = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/3*i, 0, zScreenWidth/3, 50)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btnarr addObject:btn];
        [downView addSubview:btn];
        
        UIView *yellow = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/3/2-20, 50-3, 40, 2)];
        yellow.backgroundColor = [UIColor colorHexString:@"fedb43"];
        yellow.tag = 200+i;
        [btn addSubview:yellow];
        
        [viewarr addObject:yellow];
        
        yellow.hidden = YES;
        
    }
    
    if ([typeStr isEqualToString:@"1"]) {
        ((UIButton *)[btnarr objectAtIndex:0]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:0]).hidden=NO;
    }else if ([typeStr isEqualToString:@"2"]){
        ((UIButton *)[btnarr objectAtIndex:1]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:1]).hidden=NO;
    }else{
        ((UIButton *)[btnarr objectAtIndex:2]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:2]).hidden=NO;
    }
    
    UIView *greyline = [[UIView alloc]initWithFrame:CGRectMake(0, 90, zScreenWidth, 1)];
    greyline.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:greyline];
    
    return headerView;
}

- (void)click:(UIButton *)sender{
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
        UIView *yellow = (UIView *)[[sender superview]viewWithTag:200 + i];
        yellow.hidden = YES;
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        
        typeStr = @"1";
        
        [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            hy = [[json objectForKey:@"data"] objectForKey:@"list"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else if(sender.tag == 101){
        
        typeStr = @"2";
        
        [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            rh = [[json objectForKey:@"data"] objectForKey:@"list"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }else{
        
        typeStr = @"3";
        
        [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"2"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            om = [[json objectForKey:@"data"] objectForKey:@"list"];
            
            [tableview reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([typeStr isEqualToString:@"1"]) {
        return hy.count;
    }else if ([typeStr isEqualToString:@"2"]) {
        return rh.count;
    }
    
    return om.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    IdolListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if ([typeStr isEqualToString:@"1"]) {
        
        datadic = hy[indexPath.row];
    
    }else if ([typeStr isEqualToString:@"2"]){
        datadic = rh[indexPath.row];
    }else{
        datadic = om[indexPath.row];
    }
    
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[IdolListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[datadic objectForKey:@"portrait"]];
    cell.nameLab.text = [datadic objectForKey:@"name"];
    
    
    if ([[datadic objectForKey:@"isAttention"] intValue]== 0) {
        cell.rightBtn.selected = NO;
    }else{
        cell.rightBtn.selected = YES;
    }
    
    cell.rightBtn.tag = indexPath.row;
    [cell.rightBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void)agree:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if(sender.selected == NO){
        
//        [dataarray removeObject:imgarr[sender.tag]];
//
//        [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//
//        for (int i = 0; i < dataarray.count; i++) {
//            [self creatimage:dataarray[i] andframe:CGRectMake(15+65*i, 0, 50, 50) andtag:i];
//        }
        
        
        if ([typeStr isEqualToString:@"1"]) {
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"0",@"relationIds":[hy[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    hy = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else if([typeStr isEqualToString:@"2"]){
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"0",@"relationIds":[rh[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    rh = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else {
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"0",@"relationIds":[om[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"2"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    om = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
        
        

    }
    else{
        
        if ([typeStr isEqualToString:@"1"]) {
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"1",@"relationIds":[hy[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    hy = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else if([typeStr isEqualToString:@"2"]){
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"1",@"relationIds":[rh[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    rh = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }else {
            [HTTPRequest postWithURL:@"api/member/attention/addAttention" method:@"POST" params: @{@"status":@"1",@"relationIds":[om[sender.tag] objectForKey:@"starId"],@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"starType":@"2"} ProgressHUD:self.Hud controller:self response:^(id json) {
                    
                    NSLog(@"list%@",json);
                    
                    om = [[json objectForKey:@"data"] objectForKey:@"list"];
                    
                    [tableview reloadData];
                    
                } error400Code:^(id failure) {
                    NSLog(@"%@",failure);
                }];
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
        
        
        
        
//        [dataarray addObject:imgarr[sender.tag]];
//
//        [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//
//        for (int i = 0; i < dataarray.count; i++) {
//            [self creatimage:dataarray[i] andframe:CGRectMake(15+65*i, 0, 50, 60) andtag:i];
//        }
        

    }
    
}

- (void)creatimage:(NSString *)url andframe:(CGRect)frame andtag:(int)i{
    
    UIView *view = [[UIButton alloc]initWithFrame:frame];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-25, 5, 50, 50)];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 25;
    image.layer.borderColor = [[UIColor colorHexString:@"fedb43"]CGColor];
    image.layer.borderWidth = 1;
    image.image = [UIImage imageNamed:url];
    [view addSubview:image];
    
//    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(50-18, 5, 18, 18)];
//    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"icon_delete_28x28"] forState:UIControlStateNormal];
//    [deleteBtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:deleteBtn];
    [scrollView addSubview:view];
    
}

- (void)deleteImg:(UIButton *)sender{
    
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [search resignFirstResponder];
        [HTTPRequest postWithURL:@"api/star/getList2" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"100",@"name":search.text} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            NSArray *arr = [[json objectForKey:@"data"] objectForKey:@"list"];
            
            
            if (arr.count >0) {
                if ([[arr[0] objectForKey:@"starType"] intValue] == 0) {
                    hy = [[json objectForKey:@"data"] objectForKey:@"list"];
                    typeStr = @"1";
                }else if([[arr[0] objectForKey:@"starType"] intValue] == 1) {
                    rh = [[json objectForKey:@"data"] objectForKey:@"list"];
                    typeStr = @"2";
                }else{
                    om = [[json objectForKey:@"data"] objectForKey:@"list"];
                    typeStr = @"3";
                }
                
                [tableview reloadData];
            }else{
                [tableview addSubview:nothingView];
            }
            
            
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
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
