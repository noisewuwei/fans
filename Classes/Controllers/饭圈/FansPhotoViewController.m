//
//  FansPhotoViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/16.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FansPhotoViewController.h"
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

@interface FansPhotoViewController ()<UITableViewDelegate,UITableViewDataSource,CellForWorkGroupDelegate,CellForWorkGroupRepostDelegate>{
    
    
    int _currentRequestPage; //当前请求页面
    BOOL _reCalculate;
    NSArray *array;
    UIView *backview;
}

@property (nonatomic,strong) YHRefreshTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *heightDict;

@end

@implementation FansPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[YHRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-49) style:UITableViewStyleGrouped];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = RGBCOLOR(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView setEnableLoadNew:YES];
    [self.tableView setEnableLoadMore:YES];
    
    self.view.backgroundColor = RGBCOLOR(244, 244, 244);
    
    [self.tableView registerClass:[CellForWorkGroup class] forCellReuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    
    [self.view addSubview:self.tableView];
    
    [self requestDataLoadNew:YES];
    // Do any additional setup after loading the view.
}

#pragma mark - Lazy Load
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHWorkGroup *model  = self.dataArray[indexPath.row];
    
    CellForWorkGroup *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroup class])];
    if (!cell) {
        cell = [[CellForWorkGroup alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    }
    cell.indexPath = indexPath;
    cell.model = model;
    cell.delegate = self;
    return cell;
    
    //    if (model.type == DynType_Forward) {
    //        //转发cell
    //        CellForWorkGroupRepost *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
    //        if (!cell) {
    //            cell = [[CellForWorkGroupRepost alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroupRepost class])];
    //        }
    //        cell.indexPath = indexPath;
    //        cell.model = model;
    //        cell.delegate = self;
    //        return cell;
    //    }else{
    //        //原创cell
    //        CellForWorkGroup *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForWorkGroup class])];
    //        if (!cell) {
    //            cell = [[CellForWorkGroup alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CellForWorkGroup class])];
    //        }
    //        cell.indexPath = indexPath;
    //        cell.model = model;
    //        cell.delegate = self;
    //        return cell;
    //    }
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
        
        //转发cell
        //        if (model.type == DynType_Forward) {
        //            currentClass = [CellForWorkGroupRepost class];//第一版没有转发,因此这样稍该一下
        //
        //            height = [CellForWorkGroupRepost hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        //                CellForWorkGroupRepost *cell = (CellForWorkGroupRepost *)sourceCell;
        //
        //                cell.model = model;
        //
        //            }];
        //
        //        }
        //        else{
        //
        //            height = [CellForWorkGroup hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        //                CellForWorkGroup *cell = (CellForWorkGroup *)sourceCell;
        //
        //                cell.model = model;
        //
        //            }];
        //        }
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 186;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerSectionID = @"headerSectionID";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerSectionID];
    
    if (headerView == nil) {
        
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerSectionID];
        
    }
    
    // strat
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 186)];
    backview.backgroundColor = [UIColor colorHexString:@"ececec"];
    [headerView addSubview:backview];
    
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 1, zScreenWidth, 186-1-10)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [backview addSubview:whiteview];
    
    UIImageView *bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, zScreenWidth-30, 60)];
    bigImg.contentMode = UIViewContentModeCenter;
    bigImg.image = [UIImage imageNamed:@"GZDR"];
    [headerView addSubview:bigImg];
    
    for (int i = 0; i < 5; i++) {
        [self creatBtn:[array[i] objectForKey:@"name"] withimgurl:[array[i] objectForKey:@"portrait"] andframe:CGRectMake(zScreenWidth/5*i, 90, zScreenWidth/5, 80)];
    }
    
    return headerView;
}

- (void)creatBtn:(NSString *)title withimgurl:(NSString *)url andframe:(CGRect)frame{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-22, 10, 44, 44)];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 22;
    image.backgroundColor = [UIColor blackColor];
    [image sd_setImageWithURL:[NSURL URLWithString:url]];
    [btn addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/2-30, 60, 60, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorHexString:@"383838"];
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    label.text = title;
    [btn addSubview:label];
    
    [backview addSubview:btn];
    
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
    
    
    [HTTPRequest postWithURL:@"api/club/homepage" method:@"POST" params: @{@"pageNum":[NSString stringWithFormat:@"%d",_currentRequestPage],@"pageSize":[NSString stringWithFormat:@"%d",totalCount],@"clubType":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"111111 ====== %@",json);
        
        NSDictionary *jsondic = [NSDictionary dictionaryWithDictionary:json];
        NSDictionary *data = [jsondic objectForKey:@"data"];
        NSDictionary *clubArticleList = [data objectForKey:@"clubArticleList"];
        NSArray *list = [clubArticleList objectForKey:@"list"];
        array = [data objectForKey:@"clubList"];
        
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
            model.originalPicUrls = thumbPArr;
            
            
            [self.dataArray addObject:model];
        }
        
        
        NSLog(@"222222 ====== %@",self.dataArray);
        
        
        [self.tableView loadFinish:refreshType];
        [self.tableView reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
    
    //    for (int i=0; i<totalCount; i++) {
    //        YHWorkGroup *model = [YHWorkGroup new];
    //        model.dynamicId = [NSString stringWithFormat:@"%lu", lastDynamicID + i+1];
    //        [self randomModel:model totalCount:totalCount];
    //
    //        [self.dataArray addObject:model];
    //    }
    
    
    
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
    model.userInfo.userName = nStr;
    
    CGFloat iLength = arc4random() % 3 + 1;
    NSMutableString *iStr = [NSMutableString new];
    for (int i = 0; i < iLength; i++) {
        [iStr appendString: @"测试行业"];
    }
    model.userInfo.industry = iStr;
    
    
    CGFloat cLength = arc4random() % 8 + 1;
    NSMutableString *cStr = [NSMutableString new];
    for (int i = 0; i < cLength; i++) {
        [cStr appendString: @"测试公司"];
    }
    model.userInfo.company  = cStr;
    
    
    CGFloat jLength = arc4random() % 8 + 1;
    NSMutableString *jStr = [NSMutableString new];
    for (int i = 0; i < jLength; i++) {
        [jStr appendString: @"随机职位"];
    }
    model.userInfo.job = jStr;
    
    CGFloat qlength = arc4random() % totalCount + 5;
    NSMutableString *qStr = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < qlength; ++i) {
        [qStr appendString:@"测试数据很长，测试数据很长."];
    }
    model.msgContent = qStr;
    model.publishTime = @"2013-04-17";
    
    
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
    
    if (cell.indexPath.row < [self.dataArray count]) {
        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
        
        BOOL isLike = !model.isLike;
        //更新本地数据源
        model.isLike = isLike;
        if (isLike) {
            model.likeCount += 1;
            
        }else{
            model.likeCount -= 1;
        }
        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
    
}

- (void)onShareInRepostCell:(CellForWorkGroupRepost *)cell{
    
    if (cell.indexPath.row < [self.dataArray count]){
        [self _shareWithCell:cell];
    }
}

- (void)onDeleteInRepostCell:(CellForWorkGroupRepost *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        [self _deleteDynAtIndexPath:cell.indexPath dynamicId:cell.model.dynamicId];
    }
}

- (void)onMoreInRespostCell:(CellForWorkGroupRepost *)cell{
    if (cell.indexPath.row < [self.dataArray count]) {
        YHWorkGroup *model = self.dataArray[cell.indexPath.row];
        model.isOpening = !model.isOpening;
        [self.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
