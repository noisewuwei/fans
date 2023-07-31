//
//  AddressTableViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
        UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, 125)];
        backview.backgroundColor = [UIColor whiteColor];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorHexString:@"333333"];
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth-160-15, 15, 160, 15)];
        _numLabel.font = [UIFont systemFontOfSize:16];
        _numLabel.textColor = [UIColor colorHexString:@"333333"];
        _numLabel.textAlignment = NSTextAlignmentRight;
        _adressLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 30+10, zScreenWidth-30, 40)];
        _adressLabel.numberOfLines = 0;
        _adressLabel.textColor = [UIColor colorHexString:@"333333"];
        _adressLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        
        _adressButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 125-15-19, 130, 25)];
        _adressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _adressButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _adressButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_adressButton setTitle:@"  设为默认地址" forState:UIControlStateNormal];
        [_adressButton setTitle:@"  默认地址" forState:UIControlStateSelected];
        [_adressButton setImage:[UIImage imageNamed:@"icon_disagree"] forState:UIControlStateNormal];
        [_adressButton setImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateSelected];
        [_adressButton setTitleColor:[UIColor colorHexString:@"383838"] forState:UIControlStateNormal];
        [_adressButton setTitleColor:[UIColor colorHexString:@"fddc30"] forState:UIControlStateSelected];
        _adressButton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _editButton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-135, 125-15-19, 65, 25)];
        [_editButton setTitle:@" 编辑" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@"btn_edit1.png"] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor colorHexString:@"333333"] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(zScreenWidth-70, 125-15-19, 65, 25)];
        [_deleteButton setTitle:@" 删除" forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"btn_delete2.png"] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorHexString:@"333333"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        [self.contentView addSubview:backview];
        [backview addSubview:_nameLabel];
        [backview addSubview:_numLabel];
        [backview addSubview:_adressLabel];
        [backview addSubview:_adressButton];
        [backview addSubview:_editButton];
        [backview addSubview:_deleteButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
