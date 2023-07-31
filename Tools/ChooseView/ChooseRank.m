//
//  ChooseRank.m
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/20.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import "ChooseRank.h"

@implementation ChooseRank


-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        self.frame = frame;
        self.title = title;

        self.rankArray = [NSArray arrayWithArray:titleArr];
        
        [self rankView];
    }
    return self;
}


-(void)rankView{
    
    i = 1;
    
    self.packView = [[UIView alloc] initWithFrame:self.frame];
    self.packView.y = 0;
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, zScreenWidth-30, 0.5)];
    line.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.packView addSubview:line];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, zScreenWidth, 25)];
    titleLB.text = self.title;
    titleLB.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [self.packView addSubview:titleLB];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, zScreenWidth-30, 0.5)];
    line1.backgroundColor = [UIColor colorHexString:@"ececec"];
    [self.packView addSubview:line1];
    
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleLB.frame), zScreenWidth, 40)];
    [self.packView addSubview:self.btnView];
    
    int count = 0;
    float btnWidth = 0;
    float viewHeight = 0;
    for (int i = 0; i < self.rankArray.count; i++) {
        
        NSString *btnName = self.rankArray[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor colorHexString:@"f2f2f2"]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:btnName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.layer.cornerRadius = 14;
        btn.layer.masksToBounds = YES;
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular] forKey:NSFontAttributeName];
        CGSize btnSize = [btnName sizeWithAttributes:dict];
        
        btn.width = 54;
        btn.height = 28;
        
        if (i==0)
        {
            btn.x = 20;
            btnWidth += CGRectGetMaxX(btn.frame);
        }
        else{
            btnWidth += CGRectGetMaxX(btn.frame)+20;
            if (btnWidth > zScreenWidth) {
                count++;
                btn.x = 20;
                btnWidth = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnWidth - btn.width;
            }
        }
        btn.y += count * (btn.height+10)+10;
        
        viewHeight = CGRectGetMaxY(btn.frame)+10;
        
        [self.btnView addSubview:btn];
        
        btn.tag = 10000+i;
        
        
//        if ([btnName isEqualToString:self.selectStr])
//        {
//            self.selectBtn = btn;
//            self.selectBtn.selected = YES;
//            self.selectBtn.backgroundColor = [UIColor greenColor];
//        }
        
    }
    self.btnView.height = viewHeight;
    self.packView.height = self.btnView.height+CGRectGetMaxY(titleLB.frame)+120;

    self.height = self.packView.height;
    
    
    UILabel *numtitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, zScreenWidth, 25)];
    numtitle.text = @"选择数量";
    numtitle.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [self.packView addSubview:numtitle];
    
    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(zScreenWidth-15-30-40, 160, 40, 25)];
    _numLab.text = @"1";
    _numLab.textAlignment = NSTextAlignmentCenter;
    _numLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    [self.packView addSubview:_numLab];
    
    
    _plusBtn = [[UIButton alloc] initWithFrame:CGRectMake(zScreenWidth-15-30, 160, 25, 25)];
    [_plusBtn setBackgroundImage:[UIImage imageNamed:@"pay_+"] forState:UIControlStateNormal];
    [_plusBtn addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    _plusBtn.tag = 111;
    [self.packView addSubview:_plusBtn];
    
    _minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(zScreenWidth-15-30-40-30, 160, 25, 25)];
    [_minusBtn setBackgroundImage:[UIImage imageNamed:@"pay_-"] forState:UIControlStateNormal];
    [_minusBtn addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    _minusBtn.tag = 222;
    [self.packView addSubview:_minusBtn];
    
//    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line1.frame), zScreenWidth, 80)];
//    [self.packView addSubview:self.btnView];
    
    [self addSubview:self.packView];
    
    
    
    
    
    
}

- (void)plus:(UIButton *)sender{
    

    i++;
    _numLab.text = [NSString stringWithFormat:@"%d",i];
    
    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:_numLab.text andBtn:sender];
    }
}

- (void)minus:(UIButton *)sender{
    
    
    if (i > 1) {
        i--;
        _numLab.text = [NSString stringWithFormat:@"%d",i];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:_numLab.text andBtn:sender];
    }
    
   
}


-(void)btnClick:(UIButton *)btn{
    
    
    if (![self.selectBtn isEqual:btn]) {
        
        self.selectBtn.backgroundColor = [UIColor colorHexString:@"f2f2f2"];
        self.selectBtn.selected = NO;
        
//        NSLog(@"%@-----%@",btn.titleLabel.text,[self.rankArray[btn.tag-10000] sequence]);
    }
    else{
        btn.backgroundColor = [UIColor colorHexString:@"fedb43"];
    }
    btn.backgroundColor = [UIColor colorHexString:@"fedb43"];
    btn.selected = YES;
    
    self.selectBtn = btn;

    if ([self.delegate respondsToSelector:@selector(selectBtnTitle:andBtn:)]) {
        
        [self.delegate selectBtnTitle:btn.titleLabel.text andBtn:self.selectBtn];
    }
    
    
    
}


@end







