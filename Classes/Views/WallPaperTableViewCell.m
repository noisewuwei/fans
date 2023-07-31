//
//  WallPaperTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "WallPaperTableViewCell.h"

@implementation WallPaperTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 34, 34)];
        _headImg.contentMode = UIViewContentModeCenter;
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 17;
        [self addSubview:_headImg];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15+34+8, 8+7, zScreenWidth-15-150, 20)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _titleLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_titleLab];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-15, 8+7+2.5, 15, 15)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50+312, zScreenWidth, 10)];
        line2.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line2];
        
        _Img1 = [[UIButton alloc]initWithFrame:CGRectMake(15, 50+10, zScreenWidth/2-15-3.5, 292)];
        _Img1.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img1];
        
        _Img1right = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+3.5, 50+10, zScreenWidth/2-15-3.5, 292)];
        _Img1right.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img1right];
        
        _Img2 = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+3.5, 50+10, (zScreenWidth/2-15-3.5-7)/2, 142.5)];
        _Img2.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img2];
        
        _Img3 = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+3.5+(zScreenWidth/2-15-3.5-7)/2+7, 50+10, (zScreenWidth/2-15-3.5-7)/2, 142.5)];
        _Img3.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img3];
        
        _Img4 = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+3.5, 50+10+142.5+7, (zScreenWidth/2-15-3.5-7)/2, 142.5)];
        _Img4.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img4];
        
        _Img5 = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth/2+3.5+(zScreenWidth/2-15-3.5-7)/2+7, 50+10+142.5+7, (zScreenWidth/2-15-3.5-7)/2, 142.5)];
        _Img5.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img5];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
