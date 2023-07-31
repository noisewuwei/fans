//
//  SupportContentViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/7/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"

#import "ChooseView.h"
#import "ChooseRank.h"

@interface SupportContentViewController : BaseViewController

@property(nonatomic,strong)ChooseView *chooseView;
@property(nonatomic,strong)ChooseRank *chooseRank;

@property(nonatomic,strong)NSMutableArray *rankArray;

@end
