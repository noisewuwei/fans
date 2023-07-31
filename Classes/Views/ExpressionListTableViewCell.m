//
//  ExpressionListTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "ExpressionListTableViewCell.h"

@implementation ExpressionListTableViewCell

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
        
        _titLab = [[UILabel alloc]initWithFrame:CGRectMake(15+34+8, 8+7, zScreenWidth-15-150, 20)];
        _titLab.textAlignment = NSTextAlignmentLeft;
        _titLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _titLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_titLab];
        
        _Btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-60, 8+6, 60, 22)];
        _Btn.layer.masksToBounds = YES;
        _Btn.layer.cornerRadius = 11;
        _Btn.layer.borderColor = [[UIColor colorHexString:@"c7c7c7"]CGColor];
        _Btn.layer.borderWidth = 0.5;
        [_Btn setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
        _Btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [self addSubview:_Btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 50, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line];
        
        _Img1 = [[UIImageView alloc]initWithFrame:CGRectMake((zScreenWidth-240)/8, 50+15, 60, 60)];
        _Img1.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img1];
        
        _Img2 = [[UIImageView alloc]initWithFrame:CGRectMake((zScreenWidth-240)/8+(60+(zScreenWidth-240)/8*2)*1, 50+15, 60, 60)];
        _Img2.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img2];
        
        _Img3 = [[UIImageView alloc]initWithFrame:CGRectMake((zScreenWidth-240)/8+(60+(zScreenWidth-240)/8*2)*2, 50+15, 60, 60)];
        _Img3.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img3];
        
        _Img4 = [[UIImageView alloc]initWithFrame:CGRectMake((zScreenWidth-240)/8+(60+(zScreenWidth-240)/8*2)*3, 50+15, 60, 60)];
        _Img4.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_Img4];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50+90, zScreenWidth, 10)];
        line2.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line2];
        
        
        
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
