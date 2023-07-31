//
//  SupportContentViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SupportContentViewController.h"
#import "JXButton.h"
#import "SupportContentTableViewCell.h"
#import "RankViewController.h"
#import "ConfirmOrderViewController.h"

@interface SupportContentViewController ()<UITableViewDelegate,UITableViewDataSource,ChooseRankDelegate>{
    UITableView *tableview;
}


@property(nonatomic,strong)UIView *backgroundView;

@property(nonatomic,strong)NSArray *standardList;
@property(nonatomic,strong)NSArray *standardValueList;

@end

@implementation SupportContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"应援内容";
    [self createBarLeftWithImage:@"iconback"];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-49) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    UIView *backwhite = [[UIView alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
    backwhite.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backwhite];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 4.5, zScreenWidth-30, 40)];
    doneBtn.layer.masksToBounds = YES;
    doneBtn.layer.cornerRadius = 20;
    [doneBtn setTitle:@"我要支持" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    [doneBtn addTarget:self action:@selector(chooseViewClick) forControlEvents:UIControlEventTouchUpInside];
    [backwhite addSubview:doneBtn];
    
    self.standardList = @[@"类型"];
    self.standardValueList = @[@[@"类型1",@"类型2"]];
    
    [self initChooseView];
    
    // Do any additional setup after loading the view.
}


-(void)initChooseView{
    
    self.chooseView = [[ChooseView alloc] initWithFrame:CGRectMake(0, zScreenHeight, zScreenWidth, zScreenHeight)];
    self.chooseView.headImage.image = [UIImage imageNamed:@"bingli"];
    self.chooseView.LB_price.text = @"￥36.00";
    self.chooseView.LB_stock.text = [NSString stringWithFormat:@"库存%@件",@56];
    self.chooseView.LB_detail.text = @"请选择商品规格";
    [self.view addSubview:self.chooseView];
    
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++)
    {
        
        self.chooseRank = [[ChooseRank alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, zScreenWidth, 40)];
        maxY = CGRectGetMaxY(self.chooseRank.frame);
        height += self.chooseRank.height;
        self.chooseRank.tag = 8000+i;
        self.chooseRank.delegate = self;
        
        [self.chooseView.mainscrollview addSubview:self.chooseRank];
    }
    self.chooseView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    self.chooseView.headImage.backgroundColor = [UIColor blackColor];
    //加入购物车按钮
//    [self.chooseView.addBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //立即购买
    [self.chooseView.buyBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    [self.chooseView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.chooseView.alphaView addGestureRecognizer:tap];
}


-(void)addGoodsCartBtnClick{
    
    ConfirmOrderViewController *cvc = [[ConfirmOrderViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
    
    NSLog(@"加入购物车成功");
}

#pragma mark --立即购买
-(void)chooseViewClick{
    NSLog(@"--------");
    
    
    [UIView animateWithDuration: 0.35 animations: ^{
        self.backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        self.chooseView.frame =CGRectMake(0, 0, zScreenWidth, zScreenHeight);
    } completion: nil];
    
}

/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    //    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, zScreenHeight , zScreenWidth, zScreenHeight);
        self.backgroundView.transform = CGAffineTransformIdentity;
    } completion: nil];
    
}
-(NSMutableArray *)rankArray{
    
    if (_rankArray == nil) {
        
        _rankArray = [[NSMutableArray alloc] init];
    }
    return _rankArray;
}

-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{
    
    [self.rankArray removeAllObjects];
    
    for (int i=0; i < _standardList.count; i++)
    {
        ChooseRank *view = [self.view viewWithTag:8000+i];
        
        for (UIButton *obj in  view.btnView.subviews)
        {
            if(obj.selected){
                
                for (NSArray *arr in self.standardValueList)
                {
                    for (NSString *title in arr) {
                        
                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {
                            
                            [self.rankArray addObject:view.selectBtn.titleLabel.text];
                        }
                    }
                }
            }
        }
    }
//    NSLog(@"title%@",self.rankArray);
    
    
    if (btn.tag == 111 || btn.tag == 222) {
        NSLog(@"num%@",title);
    }else{
        NSLog(@"title%@",title);
        self.chooseView.LB_detail.text = title;
    }
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 750;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 750)];
    back.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:back];
    
    UIImageView *bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, zScreenWidth-30, 150)];
    bigImg.contentMode = UIViewContentModeCenter;
    [headerView addSubview:bigImg];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, bigImg.frame.origin.y+150+12, 200, 20)];
    lab1.textAlignment = NSTextAlignmentLeft;
    lab1.textColor = [UIColor colorHexString:@"383838"];
    lab1.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    lab1.text = @"朴灿烈生日快乐";
    [headerView addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(15, lab1.frame.origin.y+20+12, 200, 20)];
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.textColor = [UIColor colorHexString:@"fd7e82"];
    lab2.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    lab2.text = @"¥88";
    [headerView addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(15, lab2.frame.origin.y+20+12, 200, 20)];
    lab3.textAlignment = NSTextAlignmentLeft;
    lab3.textColor = [UIColor colorHexString:@"777777"];
    lab3.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    lab3.text = @"2017-08-09";
    [headerView addSubview:lab3];
    
    UILabel *rightlab3 = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-150, lab3.frame.origin.y, 150, 20)];
    rightlab3.textAlignment = NSTextAlignmentRight;
    rightlab3.textColor = [UIColor colorHexString:@"777777"];
    rightlab3.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    rightlab3.text = @"已售：222";
    [headerView addSubview:rightlab3];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, lab3.frame.origin.y+20+10, zScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line1];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, line1.frame.origin.y+12, 44, 44)];
    headImg.contentMode = UIViewContentModeCenter;
    [headerView addSubview:headImg];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(15, line1.frame.origin.y+12, 200, 20)];
    lab4.textAlignment = NSTextAlignmentLeft;
    lab4.textColor = [UIColor colorHexString:@"383838"];
    lab4.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab4.text = @"朴灿烈的官方粉丝团";
    [headerView addSubview:lab4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(15, line1.frame.origin.y+12+24, 200, 20)];
    lab5.textAlignment = NSTextAlignmentLeft;
    lab5.textColor = [UIColor colorHexString:@"777777"];
    lab5.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    lab5.text = @"关注：20";
    [headerView addSubview:lab5];
    
    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-20, line1.frame.origin.y+25.5, 20, 20)];
    [agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_unfollow"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_follow"] forState:UIControlStateSelected];
    agreeBtn.selected = NO;
    agreeBtn.tag = 100;
    [headerView addSubview:agreeBtn];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y+68, zScreenWidth, 1)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line2];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.frame.origin.y+18, 200, 20)];
    lab6.textAlignment = NSTextAlignmentLeft;
    lab6.textColor = [UIColor colorHexString:@"383838"];
    lab6.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab6.text = @"完成度";
    [headerView addSubview:lab6];
    
    UIView *greyline = [[UIView alloc]initWithFrame:CGRectMake(15, lab6.frame.origin.y+20+20, zScreenWidth-30, 5)];
    greyline.layer.masksToBounds = YES;
    greyline.layer.cornerRadius = 2.5;
    greyline.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:greyline];
    
    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (zScreenWidth-30)/2, 5)];
    yellowView.layer.masksToBounds = YES;
    yellowView.layer.cornerRadius = 2.5;
    yellowView.backgroundColor = [UIColor colorHexString:@"fed843"];
    [greyline addSubview:yellowView];
    
    
    UILabel *leftlab7 = [[UILabel alloc]initWithFrame:CGRectMake(15, greyline.frame.origin.y+5+20, zScreenWidth/2-15, 20)];
    leftlab7.textAlignment = NSTextAlignmentCenter;
    leftlab7.textColor = [UIColor colorHexString:@"383838"];
    leftlab7.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    leftlab7.text = @"应援目标金额（元）";
    [headerView addSubview:leftlab7];
    
    UILabel *rightlab7 = [[UILabel alloc]initWithFrame:CGRectMake(15+zScreenWidth/2, greyline.frame.origin.y+5+20, zScreenWidth/2-15, 20)];
    rightlab7.textAlignment = NSTextAlignmentCenter;
    rightlab7.textColor = [UIColor colorHexString:@"383838"];
    rightlab7.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    rightlab7.text = @"已售金额（元）";
    [headerView addSubview:rightlab7];
    
    UILabel *leftlab8 = [[UILabel alloc]initWithFrame:CGRectMake(15, greyline.frame.origin.y+5+20+20+12, zScreenWidth/2-15, 20)];
    leftlab8.textAlignment = NSTextAlignmentCenter;
    leftlab8.textColor = [UIColor colorHexString:@"fd7e82"];
    leftlab8.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    leftlab8.text = @"¥5000";
    [headerView addSubview:leftlab8];
    
    UILabel *rightlab8 = [[UILabel alloc]initWithFrame:CGRectMake(15+zScreenWidth/2, greyline.frame.origin.y+5+20+20+12, zScreenWidth/2-15, 20)];
    rightlab8.textAlignment = NSTextAlignmentCenter;
    rightlab8.textColor = [UIColor colorHexString:@"fd7e82"];
    rightlab8.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    rightlab8.text = @"¥5000";
    [headerView addSubview:rightlab8];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y+155, zScreenWidth, 1)];
    line3.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line3];
    
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(15, line3.frame.origin.y+12, 200, 20)];
    lab9.textAlignment = NSTextAlignmentLeft;
    lab9.textColor = [UIColor colorHexString:@"383838"];
    lab9.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lab9.text = @"活动详情";
    [headerView addSubview:lab9];
    
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(15, lab9.frame.origin.y+20+20, 200, 20)];
    lab10.textAlignment = NSTextAlignmentLeft;
    lab10.textColor = [UIColor colorHexString:@"383838"];
    lab10.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    lab10.text = @"朴灿烈生日快乐";
    [headerView addSubview:lab10];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, line3.frame.origin.y+83.5, zScreenWidth, 1)];
    line4.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line4];
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(15, line4.frame.origin.y+12, 200, 20)];
    lab11.textAlignment = NSTextAlignmentLeft;
    lab11.textColor = [UIColor colorHexString:@"383838"];
    lab11.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lab11.text = @"相关明星";
    [headerView addSubview:lab11];
    
    
    UIButton *headBtn = [[JXButton alloc]initWithFrame:CGRectMake(15, lab11.frame.origin.y+20+20, 60, 72)];
    [headBtn setTitle:@"朴灿烈" forState:UIControlStateNormal];
    headBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [headBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [headBtn setImage:[UIImage imageNamed:@"user-62x62"] forState:UIControlStateNormal];
    [headerView addSubview:headBtn];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, line4.frame.origin.y+125, zScreenWidth, 1)];
    line5.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line5];
    
    UILabel *lab12 = [[UILabel alloc]initWithFrame:CGRectMake(15, line5.frame.origin.y+12, 200, 20)];
    lab12.textAlignment = NSTextAlignmentLeft;
    lab12.textColor = [UIColor colorHexString:@"383838"];
    lab12.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lab12.text = @"应援排行";
    [headerView addSubview:lab12];
    
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-80-15, line5.frame.origin.y+12, 80, 20)];
    moreBtn.layer.masksToBounds = YES;
    moreBtn.layer.cornerRadius = 20;
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:moreBtn];
    
    UIImageView *moreimage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
    moreimage.contentMode = UIViewContentModeCenter;
    moreimage.image = [UIImage imageNamed:@"more"];
    [moreBtn addSubview:moreimage];
    
    return headerView;
}

- (void)done{
    
}

- (void)more{
    RankViewController *rvc = [[RankViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}


- (void)agree:(UIButton *)sender{
    
    sender.selected = !sender.selected;
//    if(sender.selected == NO){
//        passwordLab.secureTextEntry = YES;
//    }
//    else{
//        passwordLab.secureTextEntry = NO;
//    }
    
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
