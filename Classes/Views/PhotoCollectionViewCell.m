//
//  PhotoCollectionViewCell.m
//  Fans
//
//  Created by 吴畏 on 2018/7/26.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageview = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:_imageview];
    }
    return self;
}



@end
