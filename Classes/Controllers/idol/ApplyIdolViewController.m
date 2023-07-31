//
//  ApplyIdolViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/27.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ApplyIdolViewController.h"
#import "PhotosController.h"
#import "MOFSPickerManager.h"

@interface ApplyIdolViewController ()<UITextFieldDelegate,PhotosControllerDelegate>{
    UITextField *nameText;
    UITextField *fansName;
    UILabel *birth;
    UILabel *type;
    UIButton *dateBtn;
    UIButton *typeBtn;
    UIButton *btn;
    NSMutableArray *Imgarr;
}

@end

@implementation ApplyIdolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请明星";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-45, 34, 90, 90)];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 45;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor colorHexString:@"383838"]CGColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [btn setTitle:@"上传头像" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [btn addTarget:self action:@selector(up) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:btn];
    
    NSArray *arr = @[@"姓名",@"生日",@"粉丝名",@"类型"];
    
    for (int i = 0; i<4; i++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 34+90+20+50+50*i, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [backview addSubview:line];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, btn.frame.origin.y+90+20+10+50*i, 50, 30)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorHexString:@"383838"];
        label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        label.text = arr[i];
        [backview addSubview:label];
    }
    
    nameText = [[UITextField alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*0, 150, 30)];
    nameText.textAlignment = NSTextAlignmentCenter;
    nameText.placeholder = @"输入姓名";
    nameText.delegate = self;
    nameText.returnKeyType = UIReturnKeyDone;
    nameText.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [backview addSubview:nameText];
    
    birth = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*1, 150, 30)];
    birth.textAlignment = NSTextAlignmentCenter;
    birth.text = @"点击选择生日";
    birth.textColor = [UIColor colorHexString:@"383838"];
    birth.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [backview addSubview:birth];

    UIButton *birthBth = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*1, 150, 30)];
    [birthBth addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:birthBth];
    
    fansName = [[UITextField alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*2, 150, 30)];
    fansName.textAlignment = NSTextAlignmentCenter;
    fansName.placeholder = @"输入粉丝名";
    fansName.delegate = self;
    fansName.returnKeyType = UIReturnKeyDone;
    fansName.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [backview addSubview:fansName];
    
    
    type = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*3, 150, 30)];
    type.textAlignment = NSTextAlignmentCenter;
    type.text = @"点击选择类型";
    type.textColor = [UIColor colorHexString:@"383838"];
    type.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [backview addSubview:type];
    
    UIButton *typeBth = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-75, btn.frame.origin.y+90+20+10+50*3, 150, 30)];
    [typeBth addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:typeBth];
    
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-137.5, zScreenHeight-zNavigationHeight-50-40, 275, 40)];
    done.layer.masksToBounds = YES;
    done.layer.cornerRadius = 20;
    done.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [done setTitle:@"提交申请" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
    [done setBackgroundColor:[UIColor colorHexString:@"fedb43"]];
    [done addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:done];
    

    // Do any additional setup after loading the view.
}

- (void)click{
    MOFSDatePicker *p = [MOFSDatePicker new];
    [p showMOFSDatePickerViewWithFirstDate:nil commit:^(NSDate *date) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
        dateFormatter.dateFormat=@"yyyy-MM-dd";//指定转date得日期格式化形式
        birth.text = [dateFormatter stringFromDate:date];
    } cancel:^{
        
    }];
}

- (void)click1{
    [[MOFSPickerManager shareManger] showPickerViewWithDataArray:@[@"华语",@"日韩",@"欧美"] tag:1 title:@"" cancelTitle:@"取消" commitTitle:@"确定" commitBlock:^(NSString *string) {
        type.text = string;
    } cancelBlock:^{
        
    }];
}

- (void)done{
    [HTTPRequest postWithURL:@"api/star/addnewstar" method:@"POST" params:@{@"starName":nameText.text,@"StarBirthday":birth.text,@"StarType":type.text} filePathAndKey:@{@"files":Imgarr} ProgressHUD:self.Hud  controller:self response:^(id json) {
        
        [self.navigationController popViewControllerAnimated:NO];
        
    } error400Code:^(id failure) {
        
    }];
}

- (void)up{
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
        
        Imgarr = [NSMutableArray arrayWithObject:image];
        
        [btn setImage:Imgarr[0] forState:UIControlStateNormal];
        
        
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField) {
        [textField resignFirstResponder];
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
