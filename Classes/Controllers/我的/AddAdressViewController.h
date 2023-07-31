//
//  AddAdressViewController.h
//  Fans
//
//  Created by 吴畏 on 2018/8/6.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^CallBackBlcok) (NSString *text);

@interface AddAdressViewController : BaseViewController

@property (nonatomic,copy)CallBackBlcok callBackBlock;

@property (nonatomic,strong)NSString *receiverId;
@property (nonatomic,strong)NSDictionary *dic;



@end
