//
//  IdolInfoViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/25.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "IdolInfoViewController.h"

@interface IdolInfoViewController (){
    UIImageView *topImg;
    UIImageView *headImg;
    UILabel *nameLab;
    UILabel *fansNumtext;
    UILabel *shareNumtext;
    UILabel *nickname;
    UILabel *ncompanyname;
    UILabel *workname;
    UILabel *content;
}

@end

@implementation IdolInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%@",_infodic);
    
    [topImg sd_setImageWithURL:[_infodic objectForKey:@"cover"]];
    [headImg sd_setImageWithURL:[_infodic objectForKey:@"portrait"]];
    nameLab.text = [_infodic objectForKey:@"name"];
    fansNumtext.text = [NSString stringWithFormat:@"%@",[_infodic objectForKey:@"attentionNum"]];
    shareNumtext.text = [NSString stringWithFormat:@"%@",[_infodic objectForKey:@"shareNum"]];
    nickname.text = [_infodic objectForKey:@"fansName"];
    ncompanyname.text = [_infodic objectForKey:@"agency"];
    workname.text = [_infodic objectForKey:@"works"];
    content.text = [_infodic objectForKey:@"briefInfo"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"明星资料";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth, zScreenHeight-zNavigationHeight)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 140)];
    topImg.backgroundColor = [UIColor blackColor];
    [back addSubview:topImg];
    
    headImg = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-35, 140-35, 70, 70)];
    headImg.layer.masksToBounds = YES;
    headImg.layer.cornerRadius = 35;
    headImg.layer.borderWidth = 2;
    headImg.layer.borderColor = [[UIColor colorHexString:@"fedb43"]CGColor];
    headImg.backgroundColor = [UIColor yellowColor];
    [back addSubview:headImg];
    
    
    nameLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2-40, 140+35+10, 80, 20)];
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.textColor = [UIColor colorHexString:@"383838"];
    nameLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    nameLab.text = @"lalala";
    [back addSubview:nameLab];
    
    UILabel *fansNum = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2/2-25, 140+35+10, 50, 20)];
    fansNum.textAlignment = NSTextAlignmentCenter;
    fansNum.textColor = [UIColor colorHexString:@"777777"];
    fansNum.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    fansNum.text = @"粉丝";
    [back addSubview:fansNum];
    
    UILabel *shareNum = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2+zScreenWidth/2/2-25, 140+35+10, 50, 20)];
    shareNum.textAlignment = NSTextAlignmentCenter;
    shareNum.textColor = [UIColor colorHexString:@"777777"];
    shareNum.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    shareNum.text = @"分享";
    [back addSubview:shareNum];
    
    
    fansNumtext = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2/2-25, 140+35-20, 50, 20)];
    fansNumtext.textAlignment = NSTextAlignmentCenter;
    fansNumtext.textColor = [UIColor colorHexString:@"ffb000"];
    fansNumtext.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    fansNumtext.text = @"76";
    [back addSubview:fansNumtext];
    
    shareNumtext = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2+zScreenWidth/2/2-25, 140+35-20, 50, 20)];
    shareNumtext.textAlignment = NSTextAlignmentCenter;
    shareNumtext.textColor = [UIColor colorHexString:@"ffb000"];
    shareNumtext.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    shareNumtext.text = @"23";
    [back addSubview:shareNumtext];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 140+88, zScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line1];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2-30, line1.frame.origin.y-11.5, 60, 22)];
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = [[UIColor colorHexString:@"ececec"] CGColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 11;
    btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"已关注" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorHexString:@"c7c7c7"] forState:UIControlStateNormal];
    [back addSubview:btn];
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, line1.frame.origin.y+30+50, zScreenWidth,1)];
    line2.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line2];
    
    UILabel *fansnickLab = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.frame.origin.y-15-20, 60, 20)];
    fansnickLab.textAlignment = NSTextAlignmentLeft;
    fansnickLab.textColor = [UIColor colorHexString:@"383838"];
    fansnickLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    fansnickLab.text = @"粉丝昵称";
    [back addSubview:fansnickLab];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, line2.frame.origin.y+51, zScreenWidth,1)];
    line3.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line3];
    
    UILabel *companyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, line3.frame.origin.y-15-20, 60, 20)];
    companyLab.textAlignment = NSTextAlignmentLeft;
    companyLab.textColor = [UIColor colorHexString:@"383838"];
    companyLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    companyLab.text = @"经纪公司";
    [back addSubview:companyLab];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, line3.frame.origin.y+51, zScreenWidth,1)];
    line4.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line4];
    
    UILabel *workLab = [[UILabel alloc]initWithFrame:CGRectMake(15, line4.frame.origin.y-15-20, 60, 20)];
    workLab.textAlignment = NSTextAlignmentLeft;
    workLab.textColor = [UIColor colorHexString:@"383838"];
    workLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    workLab.text = @"代表作";
    [back addSubview:workLab];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, line4.frame.origin.y+51, zScreenWidth,1)];
    line5.backgroundColor = [UIColor colorHexString:@"ececec"];
    [back addSubview:line5];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, line5.frame.origin.y-15-20, 60, 20)];
    contentLab.textAlignment = NSTextAlignmentLeft;
    contentLab.textColor = [UIColor colorHexString:@"383838"];
    contentLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    contentLab.text = @"简介";
    [back addSubview:contentLab];
    
    
    
    
    
    
    nickname = [[UILabel alloc]initWithFrame:CGRectMake(15+80, line2.frame.origin.y-15-20, zScreenWidth-15-15-80, 20)];
    nickname.textAlignment = NSTextAlignmentLeft;
    nickname.textColor = [UIColor colorHexString:@"c7c7c7"];
    nickname.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    nickname.text = @"lalala";
    [back addSubview:nickname];
    
    ncompanyname = [[UILabel alloc]initWithFrame:CGRectMake(15+80, line3.frame.origin.y-15-20, zScreenWidth-15-15-80, 20)];
    ncompanyname.textAlignment = NSTextAlignmentLeft;
    ncompanyname.textColor = [UIColor colorHexString:@"c7c7c7"];
    ncompanyname.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    ncompanyname.text = @"lalala";
    [back addSubview:ncompanyname];
    
    workname = [[UILabel alloc]initWithFrame:CGRectMake(15+80, line4.frame.origin.y-15-20, zScreenWidth-15-15-80, 20)];
    workname.textAlignment = NSTextAlignmentLeft;
    workname.textColor = [UIColor colorHexString:@"c7c7c7"];
    workname.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    workname.text = @"lalala";
    [back addSubview:workname];
    
    content = [[UILabel alloc]initWithFrame:CGRectMake(15+80, line5.frame.origin.y-15-20, zScreenWidth-15-15-80, 20)];
    content.textAlignment = NSTextAlignmentLeft;
    content.textColor = [UIColor colorHexString:@"c7c7c7"];
    content.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    content.text = @"lalala";
    [back addSubview:content];
   
    // Do any additional setup after loading the view.
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
