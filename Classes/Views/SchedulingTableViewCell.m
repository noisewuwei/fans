//
//  SchedulingTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/23.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "SchedulingTableViewCell.h"

@implementation SchedulingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        UIView *pointview = [[UIView alloc]initWithFrame:CGRectMake(15, 22.5, 15, 15)];
        pointview.layer.masksToBounds = YES;
        pointview.layer.cornerRadius = 7.5;
        pointview.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:pointview];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15+7, 37.5, 1, 150-37.5)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line];
        
        
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(15+20+10, 20, 100, 20)];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.textColor = [UIColor colorHexString:@"383838"];
        _timeLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [self addSubview:_timeLab];
        
        UIImageView *loca = [[UIImageView alloc]initWithFrame:CGRectMake(15+20+10+100, 20, 20, 20)];
        loca.contentMode = UIViewContentModeCenter;
        loca.image = [UIImage imageNamed:@"ido_location"];
        [self addSubview:loca];
        
        _wayLab = [[UILabel alloc]initWithFrame:CGRectMake(15+20+10+100+20+10, 20, 100, 20)];
        _wayLab.textAlignment = NSTextAlignmentLeft;
        _wayLab.textColor = [UIColor colorHexString:@"383838"];
        _wayLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [self addSubview:_wayLab];
        
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(35, 65, zScreenWidth-70, 50)];
        backview.backgroundColor = [UIColor colorHexString:@"f8f8f8"];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 2;
        [self addSubview:backview];
        
        UIImageView *plane = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
        plane.contentMode = UIViewContentModeCenter;
        plane.image = [UIImage imageNamed:@"ido_plan"];
        [backview addSubview:plane];
        
        _activity = [[UILabel alloc]initWithFrame:CGRectMake(10+20+10, 15,250, 20)];
        _activity.textAlignment = NSTextAlignmentLeft;
        _activity.textColor = [UIColor colorHexString:@"383838"];
        _activity.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [backview addSubview:_activity];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
