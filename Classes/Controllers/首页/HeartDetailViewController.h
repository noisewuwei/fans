//
//  HeartDetailViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/9/5.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import "ChooseView.h"
#import "ChooseRank.h"

@interface HeartDetailViewController : BaseViewController<NSObject,JSExport>

@property (nonatomic,strong) NSString *str;

@property(nonatomic,strong)ChooseView *chooseView;
@property(nonatomic,strong)ChooseRank *chooseRank;

@property(nonatomic,strong)NSMutableArray *rankArray;

@end
