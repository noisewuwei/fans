//
//  SelectIdolViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CallBackBlcok) (NSString *text);

@interface SelectIdolViewController : BaseViewController

@property (nonatomic,copy)CallBackBlcok callBackBlock;

@end
