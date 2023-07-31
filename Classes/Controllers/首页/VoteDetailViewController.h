//
//  VoteDetailViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/9/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface VoteDetailViewController : BaseViewController<NSObject,JSExport>

@property (nonatomic,strong) NSString *str;

@end
