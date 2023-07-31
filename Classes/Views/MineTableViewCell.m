//
//  MineTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/8/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 17.5, 15, 15)];
        _headImg.contentMode = UIViewContentModeCenter;
        [self addSubview:_headImg];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15+15+15, 10, 200, 30)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _nameLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_nameLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 49, zScreenWidth-30, 1)];
        line.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        [self addSubview:line];
        
        UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth-12-15, 19, 12, 12)];
        right.contentMode = UIViewContentModeCenter;
        right.image = [UIImage imageNamed:@"more"];
        [self addSubview:right];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
