//
//  ExpressionFooterCollectionReusableView.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ExpressionFooterCollectionReusableView.h"

@implementation ExpressionFooterCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, 34, 34)];
    _headImg.contentMode = UIViewContentModeCenter;
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 17;
    [self addSubview:_headImg];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(34+8, 8+7, (zScreenWidth-20)-15-150, 20)];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _nameLab.textColor = [UIColor colorHexString:@"383838"];
    [self addSubview:_nameLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, zScreenWidth-20, 1)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self addSubview:line];
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake((zScreenWidth-20)/2-34, 50+14, 68, 68)];
    [_btn setBackgroundImage:[UIImage imageNamed:@"money"] forState:UIControlStateNormal];
    [self addSubview:_btn];
    
    _downLab = [[UILabel alloc]initWithFrame:CGRectMake((zScreenWidth-20)/2-75, 50+14+68+19, 150, 20)];
    _downLab.textAlignment = NSTextAlignmentCenter;
    _downLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    _downLab.textColor = [UIColor colorHexString:@"383838"];
    [self addSubview:_downLab];
    
    
}

@end
