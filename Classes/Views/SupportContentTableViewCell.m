//
//  SupportContentTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SupportContentTableViewCell.h"

@implementation SupportContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 24.5, 15, 15)];
        _firstImg.contentMode = UIViewContentModeCenter;
        [self addSubview:_firstImg];
        
        _secondImg = [[UIImageView alloc] initWithFrame:CGRectMake(15+15+10, 12, 40, 40)];
        _secondImg.contentMode = UIViewContentModeCenter;
        [self addSubview:_secondImg];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(15+15+10+40+14, 22, 150, 20)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _name.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_name];
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth-15-100, 22, 100, 20)];
        _money.textAlignment = NSTextAlignmentRight;
        _money.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _money.textColor = [UIColor colorHexString:@"fd7e82"];
        [self addSubview:_money];
        
        
    }
    return self;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
