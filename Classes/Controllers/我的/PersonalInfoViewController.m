//
//  PersonalInfoViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "MOFSPickerManager.h"
#import "PhotosController.h"
#import "WriteRZJJViewController.h"

@interface PersonalInfoViewController ()<PhotosControllerDelegate>{
    
    UILabel *birth;
    UILabel *nick;
    UIButton *headImg;
    UILabel *sex;
    UILabel *slogan;
    NSDictionary *dic;
    
}

@end

@implementation PersonalInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBarLeftWithImage:@"iconback"];
    self.title = @"个人资料";

    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
    [self.view addSubview:back];
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, 10, zScreenWidth, 80+200)];
    white.backgroundColor = [UIColor whiteColor];
    [back addSubview:white];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 80, zScreenWidth-30, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [white addSubview:line1];
    
    for (int i = 0; i < 3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 80+50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [white addSubview:line];
    }
    
    UILabel *head = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 80, 20)];
    head.textAlignment = NSTextAlignmentLeft;
    head.textColor = [UIColor colorHexString:@"383838"];
    head.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    head.text = @"头像";
    [white addSubview:head];
    
    headImg = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5-8-54, 13, 54, 54)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 27;
    [headImg setBackgroundColor:[UIColor blackColor]];
    [headImg addTarget:self action:@selector(selectImg) forControlEvents:UIControlEventTouchUpInside];
    [white addSubview:headImg];
    
    UIImageView *headRight = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5, 32.5, 7.5, 15)];
    headRight.contentMode = UIViewContentModeCenter;
    headRight.image = [UIImage imageNamed:@"arrow"];
    [white addSubview:headRight];
    
    NSArray *arr = @[@"昵称",@"性别",@"生日",@"个性签名"];
    
    for (int i = 0; i < arr.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 80+15+50*i, 80, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr[i];
        [white addSubview:label];
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15+80+20, 80+50*i, zScreenWidth-15-80-20, 50)];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        [white addSubview:btn];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5, 80+17.5+50*i, 7.5, 15)];
        image.contentMode = UIViewContentModeCenter;
        image.image = [UIImage imageNamed:@"arrow"];
        [white addSubview:image];
        
    }
    
    nick = [[UILabel alloc]initWithFrame:CGRectMake(15+80+20, 80+15+50*0, zScreenWidth-15-80-20-15-10, 20)];
    nick.textAlignment = NSTextAlignmentRight;
    nick.textColor = [UIColor colorHexString:@"777777"];
    nick.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    nick.text = @"啦啦";
    [white addSubview:nick];
    
    sex = [[UILabel alloc]initWithFrame:CGRectMake(15+80+20, 80+15+50*1, zScreenWidth-15-80-20-15-10, 20)];
    sex.textAlignment = NSTextAlignmentRight;
    sex.textColor = [UIColor colorHexString:@"777777"];
    sex.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    sex.text = @"男";
    [white addSubview:sex];
    
    birth = [[UILabel alloc]initWithFrame:CGRectMake(15+80+20, 80+15+50*2, zScreenWidth-15-80-20-15-10, 20)];
    birth.textAlignment = NSTextAlignmentRight;
    birth.textColor = [UIColor colorHexString:@"777777"];
    birth.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    birth.text = @"2013-01-01";
    [white addSubview:birth];
    
    slogan = [[UILabel alloc]initWithFrame:CGRectMake(15+80+20, 80+15+50*3, zScreenWidth-15-80-20-15-10, 20)];
    slogan.textAlignment = NSTextAlignmentRight;
    slogan.textColor = [UIColor colorHexString:@"777777"];
    slogan.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    slogan.text = @"世界末日，追星不止！！！";
    [white addSubview:slogan];
    
    [HTTPRequest postWithURL:@"api/member/getNew" method:@"POST" params:nil ProgressHUD:self.Hud  controller:self response:^(id json) {
        
        dic = [json objectForKey:@"data"];
        
        [headImg sd_setImageWithURL:[dic objectForKey:@"portrait"] forState:UIControlStateNormal];
        nick.text = [dic objectForKey:@"nickname"];
        
        if ([[dic objectForKey:@"sex"] intValue] == 0) {
            sex.text = @"女";
        }else if ([[dic objectForKey:@"sex"] intValue] == 1){
            sex.text = @"男";
        }else{
            sex.text = @"未填写";
        }
        
        birth.text = [dic objectForKey:@"birthday"];
        
        slogan.text = [dic objectForKey:@"motto"];
        
    } error400Code:^(id failure) {
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)selectImg{
    NSLog(@"change");
    PhotosController *vc = [[PhotosController alloc] init];
    vc.title = @"相册";
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray indexrow:(NSString *)rowstr {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count>1) {
        [ZJStaticFunction alertView:self.view msg:@"只能选一张图片"];
    }else if(imagesArray.count==1){
        
        UIImage *image = [self getSubImage:imagesArray[0] mCGRect:CGRectMake(0, 0, imagesArray[0].size.width, imagesArray[0].size.width) centerBool:YES];
        
        
        [headImg setImage:image forState:UIControlStateNormal];
        
        [HTTPRequest postWithURL:@"api/member/modifymemberinfo" method:@"POST" params:nil filePathAndKey:@{@"files":@[image]} ProgressHUD:self.Hud  controller:self response:^(id json) {
            
            
            
        } error400Code:^(id failure) {
            
        }];
        
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请选择图片"];
    }
    
}

- (UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect
             centerBool:(BOOL)centerBool{
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = mCGRect.size.width;
    float viewHidth = mCGRect.size.height;
    CGRect rect;
    if(centerBool){
        rect = CGRectMake((imgWidth-viewWidth)/2,(imgHeight-viewHidth)/2,viewWidth,viewHidth);
    }else{
        if(viewHidth < viewWidth){
            if(imgWidth <= imgHeight){
                rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
            }else{
                float width = viewWidth*imgHeight/viewHidth;
                float x = (imgWidth - width)/2;
                if(x > 0){
                    rect = CGRectMake(x, 0, width, imgHeight);
                }else{
                    rect = CGRectMake(0, 0, imgWidth, imgWidth*viewHidth/viewWidth);
                }
            }
        }else{
            if(imgWidth <= imgHeight){
                float height = viewHidth*imgWidth/viewWidth;
                if(height < imgHeight){
                    rect = CGRectMake(0,0, imgWidth, height);
                }else{
                    rect = CGRectMake(0,0, viewWidth*imgHeight/viewHidth,imgHeight);
                }
            }else{
                float width = viewWidth * imgHeight / viewHidth;
                if(width < imgWidth){
                    float x = (imgWidth - width)/2;
                    rect = CGRectMake(x,0,width, imgHeight);
                }else{
                    rect = CGRectMake(0,0,imgWidth, imgHeight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef),CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


- (void)jump:(UIButton *)sender{
    
    if (sender.tag == 100) {
        WriteRZJJViewController *wvc =[[WriteRZJJViewController alloc]init];
        
        wvc.callBackBlock = ^(NSString *text){
            
            NSLog(@"%@",text);
            nick.text = text;
            
            [HTTPRequest postWithURL:@"api/member/modifymemberinfo" method:@"POST" params:@{@"nickname":text} ProgressHUD:self.Hud  controller:self response:^(id json) {
                
                
            } error400Code:^(id failure) {
                
            }];
            
        };
        
        [self.navigationController pushViewController:wvc animated:YES];
    }else if (sender.tag == 101){
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"男",@"女"] tag:1 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
            sex.text = string;
            
            [HTTPRequest postWithURL:@"api/member/modifymemberinfo" method:@"POST" params:@{@"sexType":string} ProgressHUD:self.Hud  controller:self response:^(id json) {
                
                
            } error400Code:^(id failure) {
                
            }];
            
            
        } cancelBlock:^{
            
        }];
    }else if (sender.tag == 102){
        MOFSDatePicker *p = [MOFSDatePicker new];
        [p showMOFSDatePickerViewWithFirstDate:nil commit:^(NSDate *date) {
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
            dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
            birth.text = [dateFormatter stringFromDate:date];
            
            [HTTPRequest postWithURL:@"api/member/modifymemberinfo" method:@"POST" params:@{@"sexType":[dateFormatter stringFromDate:date]} ProgressHUD:self.Hud  controller:self response:^(id json) {
                
                
            } error400Code:^(id failure) {
                
            }];
            
            
        } cancel:^{
            
        }];
    }else{
        WriteRZJJViewController *wvc =[[WriteRZJJViewController alloc]init];
        
        wvc.callBackBlock = ^(NSString *text){
            
            slogan.text = text;
            NSLog(@"%@",text);
            
            [HTTPRequest postWithURL:@"api/member/modifymemberinfo" method:@"POST" params:@{@"motto":text} ProgressHUD:self.Hud  controller:self response:^(id json) {
                
            } error400Code:^(id failure) {
                
            }];
        };
        
        [self.navigationController pushViewController:wvc animated:YES];
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
