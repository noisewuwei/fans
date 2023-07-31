//
//  ExpressionDetailViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ExpressionDetailViewController.h"
#import "PhotoCollectionViewCell.h"
#import "ExpressionFooterCollectionReusableView.h"

@interface ExpressionDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *collview;
    NSArray *dataarr;
}

@end

@implementation ExpressionDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/star/picture/getbiaoqingbao" method:@"POST" params: @{@"starId":_expressid} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        dataarr = [json objectForKey:@"data"];
        
        NSLog(@"list%@",json);
        
        [collview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"表情包";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth,zScreenHeight)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 2.设置行间距
    layout.minimumLineSpacing = 10;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake((zScreenWidth-50)/4,(zScreenWidth-50)/4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    collview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, zScreenWidth-20, zScreenHeight) collectionViewLayout:layout];
    collview.backgroundColor = [UIColor whiteColor];
    collview.dataSource = self;
    collview.delegate = self;
    collview.showsVerticalScrollIndicator = NO;
    collview.showsHorizontalScrollIndicator = NO;
    [collview registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    
    [collview registerClass:[ExpressionFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerview"];
    
    [self.view addSubview:collview];
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataarr.count;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {zScreenWidth, 0};
    return size;
}


-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {zScreenWidth, 180};
    return size;
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionFooter){
        
        
        ExpressionFooterCollectionReusableView *footV = (ExpressionFooterCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerview" forIndexPath:indexPath];
        footV.headImg.backgroundColor = [UIColor blackColor];
        footV.nameLab.text = @"啦啦啦";
        footV.downLab.text = @"123 人已打赏";
        reusableview = footV;
        
        
    }
        
    return reusableview;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = dataarr[indexPath.row];
    PhotoCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell.imageview sd_setImageWithURL:[dic objectForKey:@"image"]];
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
