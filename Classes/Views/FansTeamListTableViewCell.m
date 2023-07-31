//
//  FansTeamListTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/25.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "FansTeamListTableViewCell.h"

@implementation FansTeamListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 44, 44)];
        _headImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_headImg];
        
        _titLab = [[UILabel alloc]initWithFrame:CGRectMake(15+44+8, 12, zScreenWidth-15-44-8-15, 20)];
        _titLab.textAlignment = NSTextAlignmentLeft;
        _titLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _titLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_titLab];
        
        _contentLab = [[UILabel alloc]initWithFrame:CGRectMake(15+44+8, 12+20+4, zScreenWidth-15-44-8-15, 20)];
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _contentLab.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_contentLab];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
