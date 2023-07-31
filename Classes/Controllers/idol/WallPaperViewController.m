//
//  WallPaperViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "WallPaperViewController.h"
#import "WallPaperTableViewCell.h"
#import "WallPaperTableViewCell.h"

@interface WallPaperViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
    NSArray *dataarr;
    UIImageView *imgView;
    UIView *background;
}

@end

@implementation WallPaperViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [HTTPRequest postWithURL:@"api/star/picture/getpicturelistbytype" method:@"POST" params: @{@"starId":_starid,@"type":@"1"} ProgressHUD:self.Hud controller:self response:^(id json) {
        
        dataarr = [json objectForKey:@"data"];
        
        NSLog(@"list%@",json);
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"壁纸";
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
    return 50+312+10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    WallPaperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    NSDictionary *dic = dataarr[indexPath.row];
    NSArray *arr = [dic objectForKey:@"starPictureInfo"];
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[WallPaperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[dic objectForKey:@"cover"]];
    cell.titleLab.text = [dic objectForKey:@"name"];
    
    if (arr.count == 1) {
        
        [cell.Img1 sd_setBackgroundImageWithURL:[arr[0] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(arr.count == 2){
        [cell.Img1 sd_setBackgroundImageWithURL:[arr[0] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img1right sd_setBackgroundImageWithURL:[arr[1] objectForKey:@"image"] forState:UIControlStateNormal];
        
        [cell.Img1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img1right addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if(arr.count == 3){
        [cell.Img1 sd_setBackgroundImageWithURL:[arr[0] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img2 sd_setBackgroundImageWithURL:[arr[1] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img3 sd_setBackgroundImageWithURL:[arr[2] objectForKey:@"image"] forState:UIControlStateNormal];
        
        [cell.Img1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img2 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img3 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }else if(arr.count == 4){
        [cell.Img1 sd_setBackgroundImageWithURL:[arr[0] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img2 sd_setBackgroundImageWithURL:[arr[1] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img3 sd_setBackgroundImageWithURL:[arr[2] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img4 sd_setBackgroundImageWithURL:[arr[3] objectForKey:@"image"] forState:UIControlStateNormal];
        
        [cell.Img1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img2 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img3 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img4 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else if(arr.count == 5){
        [cell.Img1 sd_setBackgroundImageWithURL:[arr[0] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img2 sd_setBackgroundImageWithURL:[arr[1] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img3 sd_setBackgroundImageWithURL:[arr[2] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img4 sd_setBackgroundImageWithURL:[arr[3] objectForKey:@"image"] forState:UIControlStateNormal];
        [cell.Img5 sd_setBackgroundImageWithURL:[arr[4] objectForKey:@"image"] forState:UIControlStateNormal];
        
        [cell.Img1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img2 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img3 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img4 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.Img5 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (void) tapAction:(UIButton *)sender{
    
    //创建一个黑色背景
    //初始化一个用来当做背景的View。我这里为了省时间计算，宽高直接用的5s的尺寸
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,  zScreenWidth, zScreenHeight)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView（这里位置继续偷懒...没有计算）
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    //要显示的图片，即要放大的图片
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image = sender.currentBackgroundImage;
    [bgView addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imglongTapClick:)];
    //添加手势
    [imgView addGestureRecognizer:longTap];
    [imgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:bgView];//放大过程中的动画
}


-(void)imglongTapClick:(UILongPressGestureRecognizer*)gesture

{
    
    if(gesture.state==UIGestureRecognizerStateBegan)
        
    {
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"保存图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消保存图片");
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"确认保存图片");
            
            // 保存图片到相册
            UIImageWriteToSavedPhotosAlbum(imgView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
            
        }];
        
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo

{
    
    NSString *message;
    
    if(!error) {
        
        message =@"成功保存到相册";
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }else
        
    {
        
        message = [error description];
        
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }
    
}




-(void)closeView{
    [background removeFromSuperview];
}
//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
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
