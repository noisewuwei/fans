//
//  FirstTableViewCell.h
//  Fans
//
//  Created by 吴畏 on 2018/6/20.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIImageView *bigImg;
@property(nonatomic,strong) UILabel *downLab;
@property(nonatomic,strong) UILabel *moneyLab;
@property(nonatomic,strong) UILabel *numLab;

@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UILabel *soldLab;

@property(nonatomic,strong) UIView *yellowView;

@property(nonatomic,strong) UIView *line;


@end
