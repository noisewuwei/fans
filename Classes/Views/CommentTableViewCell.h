//
//  CommentTableViewCell.h
//  Fans
//
//  Created by 吴畏 on 2018/7/19.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *timeLab;
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UILabel *contentLab;


@end
