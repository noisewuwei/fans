//
//  DesignerTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/30.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "DesignerTableViewCell.h"

@implementation DesignerTableViewCell

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
        _headImg.contentMode = UIViewContentModeCenter;
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 25;
        [self addSubview:_headImg];
        
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15+50+15, 10, 100, 20)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _nameLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_nameLab];
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15+50+15, 10+20+5, 100, 20)];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _timeLab.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_timeLab];
        
        _infoLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10+50+10, zScreenWidth-30, 20)];
        _infoLab.textAlignment = NSTextAlignmentLeft;
        _infoLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _infoLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_infoLab];
        
        
        _bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10+50+10+20+10, zScreenWidth-30, 150)];
        _bigImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_bigImg];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
