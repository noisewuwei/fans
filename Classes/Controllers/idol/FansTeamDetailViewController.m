//
//  FansTeamDetailViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/25.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FansTeamDetailViewController.h"
#import "FirstTableViewCell.h"

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

@interface FansTeamDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CellForWorkGroupDelegate,CellForWorkGroupRepostDelegate>{
    int _currentRequestPage; //当前请求页面
    BOOL _reCalculate;
    NSString *typeStr;
    
    NSMutableArray *btnarr;
    NSMutableArray *viewarr;
    
    NSArray *articleListarr;
    NSDictionary *dic;
}

@property (nonatomic,strong) YHRefreshTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *heightDict;


@end

@implementation FansTeamDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/club/getclubdetail" method:@"POST" params: @{@"clubId":_FTid,@"type":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {

        articleListarr = [[json objectForKey:@"data"] objectForKey:@"articleList"];
        dic = [[json objectForKey:@"data"] objectForKey:@"clubDetails"];

        NSLog(@"list%@",json);

        [self.tableView reloadData];

    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    [self requestDataLoadNew:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"粉丝团详情";
    
    [self createBarLeftWithImage:@"iconback"];
    
    typeStr = @"1";
    
    self.tableView = [[YHRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView setEnableLoadNew:YES];
    [self.tableView setEnableLoadMore:YES];
    
    [self.tableView registerClass:[CellForWorkGroup class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    
    
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([typeStr isEqualToString:@"2"]) {
        return self.dataArray.count;
    }
    
    return articleListarr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([typeStr isEqualToString: @"2"]) {
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
    }
    
    return 391;
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 268;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 268)];
    backview.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backview];
    
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 140)];
    topImg.contentMode = UIViewContentModeScaleToFill;
    [topImg sd_setImageWithURL:[dic objectForKey:@"cover"]];
    [headerView addSubview:topImg];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 140+12, 44, 44)];
    headImg.contentMode = UIViewContentModeScaleToFill;
    [headImg sd_setImageWithURL:[dic objectForKey:@"portrait"]];
    [headerView addSubview:headImg];
    
    UILabel *titLab = [[UILabel alloc]initWithFrame:CGRectMake(15+44+8, 140+12, zScreenWidth-15-44-8-15-20, 20)];
    titLab.textAlignment = NSTextAlignmentLeft;
    titLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    titLab.textColor = [UIColor colorHexString:@"383838"];
    titLab.text =[dic objectForKey:@"name"];
    [headerView addSubview:titLab];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15+44+8, 140+12+20+4, zScreenWidth-15-44-8-15-20, 20)];
    contentLab.textAlignment = NSTextAlignmentLeft;
    contentLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    contentLab.textColor = [UIColor colorHexString:@"777777"];
    contentLab.text = [NSString stringWithFormat:@"粉丝数：%@",[dic objectForKey:@"attentionNum"]];
    [headerView addSubview:contentLab];
    

    UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-20, 140+24, 20, 20)];
    [agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_unfollow"] forState:UIControlStateNormal];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"icon_follow"] forState:UIControlStateSelected];
    agreeBtn.selected = NO;
    agreeBtn.tag = 500;
    [headerView addSubview:agreeBtn];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 140+68, zScreenWidth, 10)];
    lineview.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:lineview];
    
    
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, 268-50, zScreenWidth, 50)];
    downView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:downView];
    
    NSArray *titleArr = @[@"行程",@"动态"];
    
    btnarr = [NSMutableArray array];
    viewarr = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2*i, 0, zScreenWidth/2, 50)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btnarr addObject:btn];
        [downView addSubview:btn];
        
        UIView *yellow = [[UIView alloc]initWithFrame:CGRectMake(zScreenWidth/2/2-20, 50-3, 40, 2)];
        yellow.backgroundColor = [UIColor colorHexString:@"fedb43"];
        yellow.tag = 200+i;
        [btn addSubview:yellow];
        
        [viewarr addObject:yellow];
        
        yellow.hidden = YES;
        
    }
    
    if ([typeStr isEqualToString:@"1"]) {
        ((UIButton *)[btnarr objectAtIndex:0]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:0]).hidden=NO;
    }else{
        ((UIButton *)[btnarr objectAtIndex:1]).selected=YES;
        ((UIView *)[viewarr objectAtIndex:1]).hidden=NO;
    }
    
    return headerView;
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

- (void)click:(UIButton *)sender{
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:100 + i];
        [btn setSelected:NO];
        UIView *yellow = (UIView *)[[sender superview]viewWithTag:200 + i];
        yellow.hidden = YES;
    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    
    if (sender.tag == 100) {
        typeStr = @"1";
        [HTTPRequest postWithURL:@"api/club/getclubdetail" method:@"POST" params: @{@"clubId":_FTid,@"type":@"0"} ProgressHUD:self.Hud controller:self response:^(id json) {
            
            articleListarr = [[json objectForKey:@"data"] objectForKey:@"articleList"];
            dic = [[json objectForKey:@"data"] objectForKey:@"clubDetails"];
            
            NSLog(@"list%@",json);
            
            [self.tableView reloadData];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }else{
        typeStr = @"2";
        
        [self.tableView reloadData];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    if ([typeStr isEqualToString:@"1"]) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        NSDictionary *dict = articleListarr[indexPath.row];
        if (!cell) {
            
            //单元格样式设置为UITableViewCellStyleDefault
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
        }
        
        [cell.headImg sd_setImageWithURL:[dict objectForKey:@"clubCover"]];
        cell.titleLab.text = [dict objectForKey:@"clubName"];
        [cell.bigImg sd_setImageWithURL:[dict objectForKey:@"cover"]];
        cell.downLab.text = [dict objectForKey:@"name"];
        cell.moneyLab.text = [NSString stringWithFormat:@"¥%@-¥%@",[dict objectForKey:@"minMoney"],[dict objectForKey:@"maxMoney"]];

        NSString *str = [NSString stringWithFormat:@"%.2f%%",[[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*100];

        cell.numLab.text = str;

        cell.yellowView.frame = CGRectMake(0, 0, [[dict objectForKey:@"raisedMoney"] floatValue]/[[dict objectForKey:@"targetMoney"] floatValue]*(zScreenWidth-30), 5);
        [cell.line addSubview:cell.yellowView];

        cell.timeLab.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"endTimeForString"]];
        cell.soldLab.text = [NSString stringWithFormat:@"已售：%@",[dict objectForKey:@"soldNum"]];
        
        return cell;
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
    [HTTPRequest postWithURL:@"api/club/getclubdetail" method:@"POST" params: @{@"clubId":_FTid,@"type":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        NSLog(@"111111 ====== %@",json);
        
        NSDictionary *jsondic = [NSDictionary dictionaryWithDictionary:json];
        NSArray *list = [[jsondic objectForKey:@"data"] objectForKey:@"clubArticleList"];
        
        
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
