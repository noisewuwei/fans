//
//  CommentTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/19.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

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
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15+36+8, _headImg.frame.origin.y, 150,15 )];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _titleLab.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_titleLab];
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15+36+8, _headImg.frame.origin.y+20, 150,15 )];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _timeLab.textColor = [UIColor colorHexString:@"c7c7c7"];
        [self addSubview:_timeLab];
        
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-40, _headImg.frame.origin.y+8, 20, 20)];
        [_btn setBackgroundImage:[UIImage imageNamed:@"icon_like"] forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageNamed:@"icon_liked"] forState:UIControlStateSelected];
        [self addSubview:_btn];
        
        _contentLab = [[UILabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentLeft;
        _contentLab.textColor = [UIColor colorHexString:@"383838"];
        _contentLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
