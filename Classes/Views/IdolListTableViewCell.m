//
//  IdolListTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/27.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "IdolListTableViewCell.h"

@implementation IdolListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
        _headImg.contentMode = UIViewContentModeScaleToFill;
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 25;
        [self addSubview:_headImg];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15+50+15, 25, 100, 20)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _nameLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_nameLab];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-15, 25, 20, 20)];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_unfollow"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_follow"] forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        
        
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
