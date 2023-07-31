//
//  FirstTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 36, 36)];
        _headImg.contentMode = UIViewContentModeScaleToFill;
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 18;
        [self addSubview:_headImg];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15+36+8, _headImg.frame.origin.y+8, 150,20 )];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _titleLab.textColor = [UIColor blackColor];
        [self addSubview:_titleLab];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-12-5-40, _titleLab.frame.origin.y, 57, 20)];
        [_rightBtn setTitle:@"应援" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorHexString:@"777777"] forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [self addSubview:_rightBtn];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(57-12, 4, 12, 12)];
        img.contentMode = UIViewContentModeCenter;
        img.image = [UIImage imageNamed:@"more"];
        [_rightBtn addSubview:img];
        
        _bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, _headImg.frame.origin.y+36+12, zScreenWidth-30, 221)];
        _bigImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_bigImg];
        
        _downLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _bigImg.frame.origin.y+221+12, 200, 20)];
        _downLab.textAlignment = NSTextAlignmentLeft;
        _downLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _downLab.textColor = [UIColor blackColor];
        [self addSubview:_downLab];
        
        _moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _downLab.frame.origin.y+20+5, 100, 20)];
        _moneyLab.textAlignment = NSTextAlignmentLeft;
        _moneyLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _moneyLab.textColor = [UIColor colorHexString:@"fd7e82"];
        [self addSubview:_moneyLab];
        
        _numLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-100, _moneyLab.frame.origin.y, 100, 20)];
        _numLab.textAlignment = NSTextAlignmentRight;
        _numLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _numLab.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_numLab];
        
        
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(15, _moneyLab.frame.origin.y+10+20, zScreenWidth-30, 5)];
        _line.layer.masksToBounds = YES;
        _line.layer.cornerRadius = 2.5;
        _line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:_line];
        
        _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
        _yellowView.layer.masksToBounds = YES;
        _yellowView.layer.cornerRadius = 2.5;
        _yellowView.backgroundColor = [UIColor colorHexString:@"fed843"];
//        [_line addSubview:_yellowView];

        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15, _moneyLab.frame.origin.y+45, 150, 20)];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _timeLab.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_timeLab];
        
        _soldLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-15-100, _timeLab.frame.origin.y, 100, 20)];
        _soldLab.textAlignment = NSTextAlignmentRight;
        _soldLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _soldLab.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_soldLab];
        
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0,390.5, zScreenWidth, 0.5)];
        line1.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line1];

        
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
