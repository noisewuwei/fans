//
//  MyOrderListTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "MyOrderListTableViewCell.h"

@implementation MyOrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorHexString:@"ececec"];
        
        UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 266)];
        white.backgroundColor = [UIColor whiteColor];
        [self addSubview:white];
        
        UIView *center = [[UIView alloc]initWithFrame:CGRectMake(0, 40, zScreenWidth, 126)];
        center.backgroundColor = [UIColor colorHexString:@"fcfcfc"];
        [self addSubview:center];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 250, 20)];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _title.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_title];
        
        _status = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-80-15, 10, 80, 20)];
        _status.textAlignment = NSTextAlignmentRight;
        _status.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _status.textColor = [UIColor colorHexString:@"fd7e82"];
        [self addSubview:_status];
        
        _bigImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40+12, 100, 100)];
        _bigImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_bigImg];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12, 250, 20)];
        _name.textAlignment = NSTextAlignmentLeft;
        _name.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _name.textColor = [UIColor colorHexString:@"383838"];
        [self addSubview:_name];
        
        _type = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12+20+10, 80, 20)];
        _type.textAlignment = NSTextAlignmentLeft;
        _type.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _type.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_type];
        
        _money = [[UILabel alloc]initWithFrame:CGRectMake(15+100+10, 40+12+100-20, 80, 20)];
        _money.textAlignment = NSTextAlignmentLeft;
        _money.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _money.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_money];
        
        _number = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-80-15, 40+12+100-20, 80, 20)];
        _number.textAlignment = NSTextAlignmentRight;
        _number.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _number.textColor = [UIColor colorHexString:@"777777"];
        [self addSubview:_number];
        
        _totalmoney = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-100-15, 40+126+15, 100, 20)];
        _totalmoney.textAlignment = NSTextAlignmentRight;
        _totalmoney.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        _totalmoney.textColor = [UIColor colorHexString:@"fd7e82"];
        [self addSubview:_totalmoney];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40+126+50, zScreenWidth, 1)];
        line.backgroundColor = [UIColor colorHexString:@"ececec"];
        [self addSubview:line];
        
        _pay = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-80, 40+126+50+11, 80, 28)];
        _pay.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [_pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pay.layer.masksToBounds = YES;
        _pay.layer.cornerRadius = 14;
        [_pay setBackgroundColor:[UIColor colorHexString:@"fd7e82"]];
        [self addSubview:_pay];
        
        _cancel = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-15-80-10-80, 40+126+50+11, 80, 28)];
        _cancel.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [_cancel setTitle:@"取消订单" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
        _cancel.layer.masksToBounds = YES;
        _cancel.layer.cornerRadius = 14;
        _cancel.layer.borderWidth = 1;
        _cancel.layer.borderColor = [[UIColor colorHexString:@"c7c7c7"] CGColor];
        [self addSubview:_cancel];

    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
