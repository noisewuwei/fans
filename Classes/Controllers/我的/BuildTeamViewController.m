//
//  BuildTeamViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/7.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BuildTeamViewController.h"
#import "MOFSPickerManager.h"
#import "WriteRZJJViewController.h"
#import "PhotosController.h"

@interface BuildTeamViewController ()<UITextFieldDelegate,PhotosControllerDelegate>{
    UITextField *text;
    
    UIImageView *zimg;
    UIImageView *fimg;
    
    NSString *imgstr;
    NSString *typestr;
    
    NSString *rzjj;
    
    UIView *white1;
    
    UIView *white2;
}

@end

@implementation BuildTeamViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我要建团";
    [self createBarLeftWithImage:@"iconback"];
    [self createRightTitle:@"提交" titleColor:[UIColor colorHexString:@"383838"]];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight)];
    back.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.view addSubview:back];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight-50)];
    scrollView.contentSize = CGSizeMake(zScreenWidth, zScreenHeight*1.1);
    scrollView.backgroundColor = [UIColor colorHexString:@"ececec"];
    scrollView.canCancelContentTouches = NO;
    scrollView.directionalLockEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    white1 = [[UIView alloc]initWithFrame:CGRectMake(0, 10, zScreenWidth, 250)];
    white1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:white1];
    
    NSArray *arr1 = @[@"粉丝团类型",@"粉丝团名称",@"负责人职位",@"联系电话",@"相关艺人"];
    NSArray *plearr1 = @[@"选择粉丝团类型",@"输入粉丝团名称",@"输入负责人职位",@"输入联系电话",@"选择相关艺人"];
    
    for (int i = 0; i < arr1.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50*i, 100, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr1[i];
        [white1 addSubview:label];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [white1 addSubview:line];
        
        text = [[UITextField alloc]initWithFrame:CGRectMake(15+100, 10+50*i, zScreenWidth-15-15-100, 30)];
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.placeholder = plearr1[i];
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 100+i;
        [white1 addSubview:text];
        
    }

    white2 = [[UIView alloc]initWithFrame:CGRectMake(0, 10+250+10, zScreenWidth, 150)];
    white2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:white2];
    
    
    NSArray *arr2 = @[@"微博",@"微信",@"QQ"];
    NSArray *plearr2 = @[@"输入微博账号",@"输入微信账号",@"输入QQ账号"];
    
    for (int i = 0; i < arr2.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50*i, 100, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr2[i];
        [white2 addSubview:label];
        
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [white2 addSubview:line];
        
        text = [[UITextField alloc]initWithFrame:CGRectMake(15+100, 10+50*i, zScreenWidth-15-15-100, 30)];
        text.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        text.placeholder = plearr2[i];
        text.returnKeyType = UIReturnKeyDone;
        text.delegate = self;
        text.tag = 200+i;
        [white2 addSubview:text];
        
        
    }

    UIView *white3 = [[UIView alloc]initWithFrame:CGRectMake(0, 10+250+10+150+10, zScreenWidth, 50)];
    white3.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:white3];
    
    NSArray *arr3 = @[@"认证简介"];
    
    for (int i = 0; i < arr3.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50*i, 100, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr3[i];
        [white3 addSubview:label];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5, 17.5+50*i, 7.5, 15)];
        image.contentMode = UIViewContentModeCenter;
        image.image = [UIImage imageNamed:@"arrow"];
        [white3 addSubview:image];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15+100, 0, zScreenWidth-15-100, 50)];
        [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
        [white3 addSubview:btn];
        
    }
    
    UIView *white4 = [[UIView alloc]initWithFrame:CGRectMake(0, 10+250+10+150+10+50+10, zScreenWidth, 100)];
    white4.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:white4];
    
    NSArray *arr4 = @[@"身份证正面",@"身份证反面"];
    
    for (int i = 0; i < arr4.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+50*i, 100, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr4[i];
        [white4 addSubview:label];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [white4 addSubview:line];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5, 17.5+50*i, 7.5, 15)];
        image.contentMode = UIViewContentModeCenter;
        image.image = [UIImage imageNamed:@"arrow"];
        [white4 addSubview:image];
        
    }
    
    zimg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5-32-10, 15+50*0, 32, 20)];
    zimg.contentMode = UIViewContentModeScaleToFill;
    [white4 addSubview:zimg];
    
    UIButton *zbtn = [[UIButton alloc]initWithFrame:CGRectMake(15+100, 0, zScreenWidth-15-100, 50)];
    [zbtn addTarget:self action:@selector(zjump) forControlEvents:UIControlEventTouchUpInside];
    [white4 addSubview:zbtn];
    
    fimg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-15-7.5-32-10, 15+50*1, 32, 20)];
    fimg.contentMode = UIViewContentModeScaleToFill;
    [white4 addSubview:fimg];
    
    UIButton *fbtn = [[UIButton alloc]initWithFrame:CGRectMake(15+100, 50, zScreenWidth-15-100, 50)];
    [fbtn addTarget:self action:@selector(fjump) forControlEvents:UIControlEventTouchUpInside];
    [white4 addSubview:fbtn];
    
    UILabel *tiplabel = [[UILabel alloc]initWithFrame:CGRectMake(15, zScreenHeight-50, zScreenWidth-30, 50)];
    tiplabel.textColor = [UIColor colorHexString:@"777777"];
    tiplabel.textAlignment = NSTextAlignmentLeft;
    tiplabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    tiplabel.numberOfLines = 0;
    tiplabel.text = @"审核成功后，我们会联系您，提供PC后台管理系统，为您提供图片活动上传功能，以及配套的官方网站";
    [self.view addSubview:tiplabel];
    
    // Do any additional setup after loading the view.
}

- (void)showRight:(UIButton *)sender{
    
    UITextField *type = (UITextField *)[white1 viewWithTag:100];
    UITextField *name = (UITextField *)[white1 viewWithTag:101];
    UITextField *job = (UITextField *)[white1 viewWithTag:102];
    UITextField *phone = (UITextField *)[white1 viewWithTag:103];
    UITextField *rela = (UITextField *)[white1 viewWithTag:104];
    
    UITextField *wb = (UITextField *)[white2 viewWithTag:200];
    UITextField *wx = (UITextField *)[white2 viewWithTag:201];
    UITextField *qq = (UITextField *)[white2 viewWithTag:202];
    
    
    NSLog(@"%@",type.text);
    NSLog(@"%@",name.text);
    NSLog(@"%@",job.text);
    NSLog(@"%@",phone.text);
    NSLog(@"%@",rela.text);
    NSLog(@"%@",wb.text);
    NSLog(@"%@",wx.text);
    NSLog(@"%@",qq.text);
    
    if (type.text.length>0 && name.text.length>0 && job.text.length>0 && phone.text.length>0 && rela.text.length>0 && wb.text.length>0 && wx.text.length>0 && qq.text.length>0 && rzjj.length>0) {
        NSDictionary *dic = @{@"type":type.text,@"clubName":name.text,@"principalPosition":job.text,@"ManMobile":phone.text,@"starName":rela.text,@"weibo":wb.text,@"qq":qq.text,@"weixin":wx.text,@"demand":rzjj};
        
        
        [HTTPRequest postWithURL:@"api/club/createclub" method:@"POST" params:dic filePathAndKey:@{@"files":@[zimg.image,fimg.image]} ProgressHUD:self.Hud  controller:self response:^(id json) {
            
            [self.navigationController popViewControllerAnimated:NO];
            
        } error400Code:^(id failure) {
            
        }];
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请输入完整信息"];
    }
    
    
}

- (void)zjump{
    PhotosController *vc = [[PhotosController alloc] init];
    vc.title = @"相册";
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    imgstr = @"0";
}

- (void)fjump{
    PhotosController *vc = [[PhotosController alloc] init];
    vc.title = @"相册";
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    imgstr = @"1";
}

- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray indexrow:(NSString *)rowstr {
    NSLog(@"图片：%ld",imagesArray.count);
    if (imagesArray.count>1) {
        [ZJStaticFunction alertView:self.view msg:@"只能选一张图片"];
    }else if(imagesArray.count==1){
        
        if ([imgstr isEqualToString:@"0"]) {
            zimg.image = imagesArray[0];
        }else if ([imgstr isEqualToString:@"1"]){
            fimg.image = imagesArray[0];
        }
        
    }else{
        [ZJStaticFunction alertView:self.view msg:@"请选择图片"];
    }
    
}

- (void)jump{
    WriteRZJJViewController *wvc =[[WriteRZJJViewController alloc]init];
    
    wvc.callBackBlock = ^(NSString *text){
        
        rzjj = text;
        NSLog(@"%@",text);
        
    };
    
    [self.navigationController pushViewController:wvc animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        
        [textField resignFirstResponder];
        
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 100) {
        NSLog(@"hahah");
        
        [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"娱乐机构",@"粉丝团"] tag:1 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
            textField.text = string;
            typestr = string;
        } cancelBlock:^{
            
        }];

        
        return NO;
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
