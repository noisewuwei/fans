//
//  AddressTableViewCell.h
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *numLabel;
@property(nonatomic,strong) UILabel *adressLabel;
@property(nonatomic,strong) UIButton *adressButton;
@property(nonatomic,strong) UIButton *editButton;
@property(nonatomic,strong) UIButton *deleteButton;

@end
