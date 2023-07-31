//
//  AddressListViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CallBack) (NSDictionary *dic);

@interface AddressListViewController : BaseViewController

@property (nonatomic,copy)CallBack callBack;

@property (nonatomic,strong)NSString *str;

@end
