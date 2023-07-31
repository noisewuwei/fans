//
//  MyOrderListTableViewCell.h
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderListTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *bigImg;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *status;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *type;
@property(nonatomic,strong) UILabel *money;
@property(nonatomic,strong) UILabel *number;
@property(nonatomic,strong) UILabel *totalmoney;
@property(nonatomic,strong) UIButton *cancel;
@property(nonatomic,strong) UIButton *pay;

@end
