//
//  ThirdViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ThirdViewController.h"
#import "FirstTableViewCell.h"
#import "LYTBackView.h"
#import "SchedulingTableViewCell.h"
#import "FansTeamListViewController.h"
#import "IdolInfoViewController.h"
#import "ExpressionListViewController.h"
#import "WallPaperViewController.h"
#import "PictureViewController.h"
#import "SelectIdolViewController.h"
#import "ApplyIdolViewController.h"

#import "CellForWorkGroup.h"
#import "CellForWorkGroupRepost.h"
#import "YHRefreshTableView.h"
#import "YHWorkGroup.h"
#import "YHUserInfoManager.h"
#import "YHUtils.h"
#import "YHSharePresentView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"


#import "DetailWebViewController.h"
#import "CommentViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,CellForWorkGroupDelegate,CellForWorkGroupRepostDelegate>{
    NSString *typeStr;
    UIView *backview;
    NSMutableArray *btnarr;
    NSMutableArray *viewarr;
    UIScrollView * scrollView;
    UIView *popview;
    UIButton *right;
    
    NSArray *tripdataarr;
    NSArray *articleListarr;
    NSArray *articlearr;
    NSMutableArray *starlist;
    
    NSDictionary *starinfo;
    
    NSString *starid;
    
    int _currentRequestPage; //当前请求页面
    BOOL _reCalculate;
}

@property (nonatomic,strong) YHRefreshTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *heightDict;

@end

@implementation ThirdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    right.hidden = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    typeStr = @"1";
    
    self.title = @"idol";
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    self.tableView = [[YHRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-zToolBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView setEnableLoadNew:YES];
    [self.tableView setEnableLoadMore:YES];
    
    [self.tableView registerClass:[CellForWorkGroup class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    
    right = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-39, 64-5-39, 39, 39)];
    right.layer.masksToBounds = YES;
    right.layer.cornerRadius = 19.5;
    [right addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:right];

    
    [HTTPRequest postWithURL:@"api/member/attention/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSDictionary *dic = [json objectForKey:@"data"];
        
        starlist = [NSMutableArray arrayWithArray:[dic objectForKey:@"list"]];
        
        [right sd_setBackgroundImageWithURL:[starlist[0] objectForKey:@"portrait"] forState:UIControlStateNormal];
        
        starid = [starlist[0] objectForKey:@"starId"];
        
        [self requestDataLoadNew:YES];
        
        [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"starId":[starlist[0] objectForKey:@"starId"],@"pageType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            tripdataarr = [[json objectForKey:@"data"] objectForKey:@"starTrips"];
            starinfo = [[json objectForKey:@"data"] objectForKey:@"starInfo"];
            
            [_tableView reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)heightDict{
    if (!_heightDict) {
        _heightDict = [NSMutableDictionary new];
    }
    return _heightDict;
}

- (void)right:(UIButton *)sender{
    
    popview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, 119)];
    popview.backgroundColor = [UIColor colorHexString:@"ececec"];
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, zScreenWidth, 118)];
    scrollView.contentSize = CGSizeMake(zScreenWidth*2, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [popview addSubview:scrollView];
    
    popview.hidden = NO;
    scrollView.hidden = NO;
    
    NSDictionary *dic = @{@"starId":@"",@"name":@"添加",@"portrait":@"http://p66gdbc2t.bkt.clouddn.com/4c8f31cbfa9b451bb9756929d658308e.png",@"attentionNum":@"0"};
    
    if (![starlist.lastObject isEqual:dic]) {
        [starlist addObject:dic];
    }
    
    
    
    
    for (int i = 0; i < starlist.count; i++) {
        [self creatBigBtn:[starlist[i] objectForKey:@"name"] withimgurl:[starlist[i] objectForKey:@"portrait"] andframe:CGRectMake(15+zScreenWidth/4*i, 0, zScreenWidth/6, 128) andtag:100+i];
    }
    
    if (sender.selected == NO) {
        [LYTBackView showWithView:popview];
        sender.selected = YES;
    }else{
        [LYTBackView dissMiss];
        sender.selected = NO;
        
    }
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([typeStr isEqualToString:@"3"]) {
        return self.dataArray.count;
    }else if ([typeStr isEqualToString:@"1"]) {
        return tripdataarr.count;
    }
    
    return articleListarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([typeStr isEqualToString: @"3"]) {
        if (indexPath.row < self.dataArray.count) {
            
            CGFloat height = 0.0;
            //原创cell
            Class currentClass  = [CellForWorkGroup class];
            YHWorkGroup *model  = self.dataArray[indexPath.row];
            
            //取缓存高度
            NSDictionary *dict =  self.heightDict[model.dynamicId];
            if (dict) {
                if (model.isOpening) {
                    height = [dict[@"open"] floatValue];
                }else{
                    height = [dict[@"normal"] floatValue];
                }
                if (height) {
                    return height;
                }
            }
            
            height = [CellForWorkGroup hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                CellForWorkGroup *cell = (CellForWorkGroup *)sourceCell;
                cell.model = model;
            }];
            
            //缓存高度
            if (model.dynamicId) {
                NSMutableDictionary *aDict = [NSMutableDictionary new];
                if (model.isOpening) {
                    [aDict setObject:@(height) forKey:@"open"];
                }else{
                    [aDict setObject:@(height) forKey:@"normal"];
                }
                [self.heightDict setObject:aDict forKey:model.dynamicId];
            }
            return height;
        }
        else{
            return 44.0f;
        }
    }else if([typeStr isEqualToString:@"2"]){
        return 391;
    }
    return 150;
    
    
    
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
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 218)];
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
    // strat
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 80, zScreenWidth, 1)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:line];
 
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
//    img.layer.masksToBounds = YES;
//    img.layer.cornerRadius = 30;
//    img.backgroundColor = [UIColor blackColor];
//    [headerView addSubview:img];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 30;
    headImg.backgroundColor = [UIColor blackColor];
    [headImg sd_setImageWithURL:[starinfo objectForKey:@"portrait"]];
    [headerView addSubview:headImg];
    
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(15+60+10, 10, 100, 25)];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.textColor = [UIColor colorHexString:@"383838"];
    namelabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    namelabel.text = [starinfo objectForKey:@"name"];
    [headerView addSubview:namelabel];
    
    UILabel *fannumlabel = [[UILabel alloc]initWithFrame:CGRectMake(15+60+10, 20+25, 100, 25)];
    fannumlabel.textAlignment = NSTextAlignmentLeft;
    fannumlabel.textColor = [UIColor colorHexString:@"777777"];
    fannumlabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    fannumlabel.text = [starinfo objectForKey:@"works"];
    [headerView addSubview:fannumlabel];
    
    NSArray *namearr = @[@"粉丝团",@"图片",@"壁纸",@"表情",@"资料"];
    NSArray *imgarr = @[@"ido_fans",@"ido_pic",@"ido_bg",@"ido-biaoqing",@"ido-ziliao"];
    
    for (int i = 0; i < 5; i++) {
        [self creatBtn:namearr[i] withimgurl:imgarr[i] andframe:CGRectMake(zScreenWidth/5*i, 90, zScreenWidth/5, 78) andtag:112+i];
    }
    
    
    UIView *grey = [[UIView alloc]initWithFrame:CGRectMake(0, 218-50-10, zScreenWidth, 10)];
    grey.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:grey];
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 218-50, zScreenWidth, 50)];
    downView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:downView];
    
    
    NSArray *titleArr = @[@"行程",@"活动",@"动态"];
    
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
    
    UIView *greyline = [[UIView alloc]initWithFrame:CGRectMake(0, 218-1, zScreenWidth, 1)];
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
        
        
        [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"starId":[starlist[0] objectForKey:@"starId"],@"pageType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            tripdataarr = [[json objectForKey:@"data"] objectForKey:@"starTrips"];
            starinfo = [[json objectForKey:@"data"] objectForKey:@"starInfo"];
            
            [_tableView reloadData];
            
            
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];

    }else if(sender.tag == 101){

        
        typeStr = @"2";
        
        [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"starId":[starlist[0] objectForKey:@"starId"],@"pageType":@"2"} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"list%@",json);
            articleListarr = [[json objectForKey:@"data"] objectForKey:@"articleList"];
            starinfo = [[json objectForKey:@"data"] objectForKey:@"starInfo"];
            [_tableView reloadData];
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }else{
        typeStr = @"3";
        [_tableView reloadData];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    static NSString *ID1 = @"cell1";
    static NSString *ID2 = @"cell2";
    
    if ([typeStr isEqualToString:@"1"]) {
        SchedulingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        NSDictionary *dic = tripdataarr[indexPath.row];
        
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[SchedulingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        
        NSString *timeStampString  = [dic objectForKey:@"updateTime"];
        NSTimeInterval interval =[timeStampString doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        cell.timeLab.text = [formatter stringFromDate: date];
        cell.wayLab.text = [dic objectForKey:@"position"];
        cell.activity.text = [dic objectForKey:@"information"];
        
        return cell;
    }else if([typeStr isEqualToString:@"2"]){
        FirstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID1];
        NSDictionary *dict = articleListarr[indexPath.row];
        if (!cell1) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell1 = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
            cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        }
        
        [cell1.headImg sd_setImageWithURL:[dict objectForKey:@"clubCover"]];
        cell1.titleLab.text = [dict objectForKey:@"clubName"];
        [cell1.bigImg sd_setImageWithURL:[dict objectForKey:@"cover"]];
        cell1.downLab.text = [dict objectForKey:@"name"];
        cell1.moneyLab.text = [NSString stringWithFormat:@"¥%@-¥%@",[dict objectForKey:@"minMoney"],[dict objectForKey:@"maxMoney"]];
        
        if ([[dict objectForKey:@"activityType"] intValue] == 4){
            
            cell1.line.hidden = YES;
            
            
            
        }else{
            NSString *str = [NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*100];
            
            cell1.numLab.text = str;
            
            if ([[dict objectForKey:@"targetMoney"] intValue] == 0) {
                cell1.line.hidden = YES;
            }else{
                cell1.line.hidden = NO;
                cell1.yellowView.frame = CGRectMake(0, 0, [[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*(zScreenWidth-30), 5);
            }
            
            [cell1.line addSubview:cell1.yellowView];
        }
        
        cell1.timeLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"endTimeForString"]];
        cell1.soldLab.text = [NSString stringWithFormat:@"已售：%@",[dict objectForKey:@"soldNum"]];
        
        
        return cell1;
    }else{
        
        YHWorkGroup *model  = self.dataArray[indexPath.row];
        
        CellForWorkGroup *cell3 = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroup class])];
        if (!cell3) {
            cell3 = [[CellForWorkGroup alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
        }
        cell3.indexPath = indexPath;
        cell3.model = model;
        cell3.delegate = self;
        return cell3;
    }
    
    return nil;
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 网络请求
- (void)requestDataLoadNew:(BOOL)loadNew{
    YHRefreshType refreshType;
    if (loadNew) {
        _currentRequestPage = 1;
        refreshType = YHRefreshType_LoadNew;
        [self.tableView setNoMoreData:NO];
    }
    else{
        _currentRequestPage ++;
        refreshType = YHRefreshType_LoadMore;
    }
    
    [self.tableView loadBegin:refreshType];
    if (loadNew) {
        [self.dataArray removeAllObjects];
        [self.heightDict removeAllObjects];
    }
    
    int totalCount = 10;
    
    NSUInteger lastDynamicID = 0;
    if (!loadNew && self.dataArray.count) {
        YHWorkGroup *model = self.dataArray.lastObject;
        lastDynamicID = [model.dynamicId integerValue];
    }
    [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":[NSString stringWithFormat:@"%d",_currentRequestPage],@"pageSize":[NSString stringWithFormat:@"%d",totalCount],@"starId":[starlist[0] objectForKey:@"starId"],@"pageType":@"3"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"111111 ====== %@",json);

        NSDictionary *jsondic = [NSDictionary dictionaryWithDictionary:json];
        NSArray *list = [[jsondic objectForKey:@"data"] objectForKey:@"article"];


        for (NSDictionary *dic in list) {
            YHWorkGroup *model = [YHWorkGroup new];
            
            model.type = DynType_Original;//动态类型

            YHUserInfo *userInfo = [YHUserInfo new];
            model.userInfo = userInfo;

            model.userInfo.avatarUrl = [NSURL URLWithString:[[dic objectForKey:@"club"] objectForKey:@"portrait"]];
            model.userInfo.userName = [[dic objectForKey:@"club"] objectForKey:@"name"];
            
            NSString *timeStampString  = [[dic objectForKey:@"club"] objectForKey:@"updateTime"];
            NSTimeInterval interval =[timeStampString doubleValue] / 1000.0;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            model.userInfo.company = [formatter stringFromDate: date];
            
            model.msgContent = [dic objectForKey:@"title"];
            model.dynamicId = [dic objectForKey:@"articleId"];

            NSMutableArray *thumbPArr = [NSMutableArray new];
            for (NSString *str in [[dic objectForKey:@"images"] componentsSeparatedByString:@","]) {
                [thumbPArr addObject:[NSURL URLWithString:str]];
            }

            model.thumbnailPicUrls = thumbPArr;


            [self.dataArray addObject:model];
        }


        NSLog(@"222222 ====== %@",self.dataArray);


        [self.tableView loadFinish:refreshType];
        [self.tableView reloadData];

    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
}

#pragma mark - 模拟产生数据源
- (void)randomModel:(YHWorkGroup *)model totalCount:(int)totalCount{
    
    model.type = arc4random()%totalCount %2? DynType_Forward:DynType_Original;//动态类型
    if (model.type == DynType_Forward) {
        model.forwardModel = [YHWorkGroup new];
        [self creatOriModel:model.forwardModel totalCount:totalCount];
    }
    [self creatOriModel:model totalCount:totalCount];
    
}

- (void)creatOriModel:(YHWorkGroup *)model totalCount:(int)totalCount{
    YHUserInfo *userInfo = [YHUserInfo new];
    model.userInfo = userInfo;
    
    
    NSArray *avtarArray = @[
                            @"http://testapp.gtax.cn/images/2016/11/05/812eb442b6a645a99be476d139174d3c.png!m90x90.png",
                            @"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png",
                            @"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg",
                            @"https://testapp.gtax.cn/images/2016/09/14/c6ab40b1bc0e4bf19e54107ee2299523.jpg!m90x90.jpg",
                            @"http://testapp.gtax.cn/images/2016/11/14/8d4ee23d9f5243f98c79b9ce0c699bd9.png!m90x90.png",
                            @"https://testapp.gtax.cn/images/2016/09/14/8cfa9bd12e6844eea0a2e940257e1186.jpg!m90x90.jpg"];
    int avtarIndex = arc4random() % avtarArray.count;
    if (avtarIndex < avtarArray.count) {
        model.userInfo.avatarUrl = [NSURL URLWithString:avtarArray[avtarIndex]];
    }
    
    
    CGFloat myIdLength = arc4random() % totalCount;
    int result = (int)myIdLength % 2;
    model.userInfo.uid = result ?   [YHUserInfoManager sharedInstance].userInfo.uid:@"2";
    
    CGFloat nLength = arc4random() % 3 + 1;
    NSMutableString *nStr = [NSMutableString new];
    for (int i = 0; i < nLength; i++) {
        [nStr appendString: @"测试名字"];
    }
    model.userInfo.userName = @"朴灿烈官方粉丝团";
    model.userInfo.industry = @"";
    model.userInfo.company  = @"2018-1-1";
    model.userInfo.job = @"";
    model.msgContent = @"哈哈哈哈哈哈哈哈";
    model.publishTime = @"";
    
    
    CGFloat picLength = arc4random() % 9;
    
    //原图
    NSArray *oriPName = @[
                          @"https://testapp.gtax.cn/images/2016/08/25/2241c4b32b8445da87532d6044888f3d.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/0abd8670e96e4357961fab47ba3a1652.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/5cd8aa1f1b1f4b2db25c51410f473e60.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/5e8b978854ef4a028d284f6ddc7512e0.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/03c58da45900428796fafcb3d77b6fad.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/dbee521788da494683ef336432028d48.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/4cd95742b6744114ac8fa41a72f83257.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/4d49888355a941cab921c9f1ad118721.jpg",
                          
                          @"https://testapp.gtax.cn/images/2016/08/25/ea6a22e8b4794b9ba63fd6ee587be4d1.jpg"];
    
    NSMutableArray *oriPArr = [NSMutableArray new];
    for (NSString *pName in oriPName) {
        [oriPArr addObject:[NSURL URLWithString:pName]];
    }
    
    //小图
    NSArray *thumbPName = @[
                            @"https://testapp.gtax.cn/images/2016/08/25/2241c4b32b8445da87532d6044888f3d.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/0abd8670e96e4357961fab47ba3a1652.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/5cd8aa1f1b1f4b2db25c51410f473e60.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/5e8b978854ef4a028d284f6ddc7512e0.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/03c58da45900428796fafcb3d77b6fad.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/dbee521788da494683ef336432028d48.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/4cd95742b6744114ac8fa41a72f83257.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/4d49888355a941cab921c9f1ad118721.jpg!t300x300.jpg",
                            
                            @"https://testapp.gtax.cn/images/2016/08/25/ea6a22e8b4794b9ba63fd6ee587be4d1.jpg!t300x300.jpg"];
    
    NSMutableArray *thumbPArr = [NSMutableArray new];
    for (NSString *pName in thumbPName) {
        [thumbPArr addObject:[NSURL URLWithString:pName]];
    }
    
    model.originalPicUrls = [oriPArr subarrayWithRange:NSMakeRange(0, picLength)];
    model.thumbnailPicUrls = [thumbPArr subarrayWithRange:NSMakeRange(0, picLength)];
}

#pragma mark - YHRefreshTableViewDelegate
- (void)refreshTableViewLoadNew:(YHRefreshTableView*)view{
    [self requestDataLoadNew:YES];
}

- (void)refreshTableViewLoadmore:(YHRefreshTableView*)view{
    [self requestDataLoadNew:NO];
}


#pragma mark - CellForWorkGroupDelegate
- (void)onAvatarInCell:(CellForWorkGroup *)cell{
    
}

- (void)onMoreInCell:(CellForWorkGroup *)cell{
    //    DDLog(@"查看详情");
    //    if (cell.indexPath.row < [self.dataArray count]) {
    //        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
    //        model.isOpening = !model.isOpening;
    //        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //    }
    
}

- (void)onCommentInCell:(CellForWorkGroup *)cell{
    
    DetailWebViewController *dvc = [[DetailWebViewController alloc]init];
    
    YHWorkGroup *model = self.dataArray[cell.indexPath.row];
    
    dvc.str = model.dynamicId;
    
    UINavigationController *cvcn = [[UINavigationController alloc]initWithRootViewController:dvc];
    [self presentViewController:cvcn animated:YES completion:nil];
    
}

- (void)onLikeInCell:(CellForWorkGroup *)cell{
    
    YHWorkGroup *model = self.dataArray[cell.indexPath.row];
    
    NSArray* imageArray = model.thumbnailPicUrls;
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"test"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"www.dui3.cn"]
                                          title:@"share"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        
        [ShareSDK showShareActionSheet:nil customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
    }
    
}

- (void)onShareInCell:(CellForWorkGroup *)cell{
    
    CommentViewController *cvc = [[CommentViewController alloc]init];
    
    YHWorkGroup *model = self.dataArray[cell.indexPath.row];
    
    cvc.relationIdstr = model.dynamicId;
    UINavigationController *cvcn = [[UINavigationController alloc]initWithRootViewController:cvc];
    [self presentViewController:cvcn animated:YES completion:nil];
}


- (void)onDeleteInCell:(CellForWorkGroup *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        [self _deleteDynAtIndexPath:cell.indexPath dynamicId:cell.model.dynamicId];
    }
}

#pragma mark - CellForWorkGroupRepostDelegate

- (void)onAvatarInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onTapRepostViewInCell:(CellForWorkGroupRepost *)cell{
}

- (void)onCommentInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onLikeInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onShareInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onDeleteInRepostCell:(CellForWorkGroupRepost *)cell{
}

- (void)onMoreInRespostCell:(CellForWorkGroupRepost *)cell{
}


#pragma mark - private
- (void)_deleteDynAtIndexPath:(NSIndexPath *)indexPath dynamicId:(NSString *)dynamicId{
    
    WeakSelf
    [YHUtils showAlertWithTitle:@"删除动态" message:@"您确定要删除此动态?" okTitle:@"确定" cancelTitle:@"取消" inViewController:self dismiss:^(BOOL resultYes) {
        
        if (resultYes)
        {
            
            DDLog(@"delete row is %ld",(long)indexPath.row);
            
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.heightDict removeObjectForKey:dynamicId];
            [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }];
    
}

- (void)_shareWithCell:(UITableViewCell *)cell{
    
    CellForWorkGroup *cellOri     = nil;
    CellForWorkGroupRepost *cellRepost = nil;
    BOOL isRepost = NO;
    if ([cell isKindOfClass:[CellForWorkGroup class]]) {
        cellOri = (CellForWorkGroup *)cell;
    }
    else if ([cell isKindOfClass:[CellForWorkGroupRepost class]]) {
        cellRepost = (CellForWorkGroupRepost *)cell;
        isRepost   = YES;
    }
    else
        return;
    
    
    YHWorkGroup *model = [YHWorkGroup new];
    if (isRepost) {
        model = cellRepost.model.forwardModel;
    }
    else{
        model = cellOri.model;
    }
    
    YHSharePresentView *shareView = [[YHSharePresentView alloc] init];
    shareView.shareType = ShareType_WorkGroup;
    [shareView show];
    [shareView dismissHandler:^(BOOL isCanceled, NSInteger index) {
        if (!isCanceled) {
            switch (index)
            {
                case 2:
                {
                    DDLog(@"动态");
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                    
                case 0:
                {
                    //朋友圈
                    DDLog(@"朋友圈");
                    
                }
                    break;
                case 1:
                {
                    //微信好友
                    DDLog(@"微信好友");
                    
                }
                    break;
                default:
                    break;
            }
            
        }
    }];
    
    
    
}

- (void)creatBtn:(NSString *)title withimgurl:(NSString *)url andframe:(CGRect)frame andtag:(int)i{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    btn.tag = i;
    [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-15, 0, 30, 30)];
    image.image = [UIImage imageNamed:url];
    [btn addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-25, 40, 50, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorHexString:@"383838"];
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    label.text = title;
    [btn addSubview:label];
    
    [backview addSubview:btn];
    
}

- (void)jump:(UIButton *)sender{
    if (sender.tag == 112) {
        FansTeamListViewController *fvc = [[FansTeamListViewController alloc]init];
        fvc.hidesBottomBarWhenPushed = YES;
        fvc.starid = starid;
        right.hidden = YES;
        [self.navigationController pushViewController:fvc animated:YES];
    }else if (sender.tag == 115){
        ExpressionListViewController *evc = [[ExpressionListViewController alloc]init];
        evc.hidesBottomBarWhenPushed = YES;
        evc.starid = starid;
        right.hidden = YES;
        [self.navigationController pushViewController:evc animated:YES];
    }else if (sender.tag == 116){
        IdolInfoViewController *ivc = [[IdolInfoViewController alloc]init];
        ivc.hidesBottomBarWhenPushed = YES;
        ivc.infodic = starinfo;
        right.hidden = YES;
        [self.navigationController pushViewController:ivc animated:YES];
    }else if (sender.tag == 114){
        WallPaperViewController *wvc = [[WallPaperViewController alloc]init];
        wvc.hidesBottomBarWhenPushed = YES;
        wvc.starid = starid;
        right.hidden = YES;
        [self.navigationController pushViewController:wvc animated:YES];
    }else if (sender.tag == 113){
        PictureViewController *pvc = [[PictureViewController alloc]init];
        pvc.hidesBottomBarWhenPushed = YES;
        pvc.starid = starid;
        right.hidden = YES;
        [self.navigationController pushViewController:pvc animated:YES];
    }
}

- (void)creatBigBtn:(NSString *)title withimgurl:(NSString *)url andframe:(CGRect)frame andtag:(int)i{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn addTarget:self action:@selector(selecthead:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = i;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-30, 17, 60, 60)];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 30;
    [image sd_setImageWithURL:url];
    
    [btn addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-30, 80, 60, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorHexString:@"777777"];
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label.text = title;
    [btn addSubview:label];
    
    [scrollView addSubview:btn];
    
}

- (void)load{
    [HTTPRequest postWithURL:@"api/member/attention/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"relationType":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSDictionary *dic = [json objectForKey:@"data"];
        
        starlist = [NSMutableArray arrayWithArray:[dic objectForKey:@"list"]];
        
        [right sd_setBackgroundImageWithURL:[starlist[0] objectForKey:@"portrait"] forState:UIControlStateNormal];
        
        starid = [starlist[0] objectForKey:@"starId"];
        
        [self requestDataLoadNew:YES];
        
        [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"starId":[starlist[0] objectForKey:@"starId"],@"pageType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            
            tripdataarr = [[json objectForKey:@"data"] objectForKey:@"starTrips"];
            starinfo = [[json objectForKey:@"data"] objectForKey:@"starInfo"];
            
            [_tableView reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)selecthead:(UIButton *)sender{
    
    if (sender.tag == 99+starlist.count) {
        SelectIdolViewController *svc = [[SelectIdolViewController alloc]init];
        svc.hidesBottomBarWhenPushed = YES;
        
        svc.callBackBlock = ^(NSString *text){
            
            [self load];
            
        };
        
        right.hidden = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }else{
        
        starid = [starlist[sender.tag-100] objectForKey:@"starId"];
        
        [right sd_setBackgroundImageWithURL:[starlist[sender.tag-100] objectForKey:@"portrait"] forState:UIControlStateNormal];
        
        typeStr = @"1";
        
        [HTTPRequest postWithURL:@"api/idol/gethomepage" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"20",@"starId":[starlist[sender.tag-100] objectForKey:@"starId"],@"pageType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            NSLog(@"list%@",json);
            

            tripdataarr = [[json objectForKey:@"data"] objectForKey:@"starTrips"];
            starinfo = [[json objectForKey:@"data"] objectForKey:@"starInfo"];
            
            [_tableView reloadData];
   
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }
    
    right.selected = NO;
    [LYTBackView dissMiss];
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
