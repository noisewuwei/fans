//
//  WriteRZJJViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/8/7.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "WriteRZJJViewController.h"

@interface WriteRZJJViewController ()<UITextViewDelegate,UITextFieldDelegate>{
    UITextView *text;
    UILabel *pleLabel;
    
}

@end

@implementation WriteRZJJViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createBarLeftWithImage:@"iconback"];
    self.title = @"填写内容";
    [self createRightTitle:@"提交" titleColor:[UIColor colorHexString:@"383838"]];
    
    UIView *white = [[UIView alloc]initWithFrame:CGRectMake(0, zNavigationHeight, zScreenWidth,zScreenHeight-zNavigationHeight)];
    white.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:white];
    
    text = [[UITextView alloc]initWithFrame:CGRectMake(15,zNavigationHeight+10, zScreenWidth-30, zScreenHeight-zNavigationHeight-10)];
    text.backgroundColor = [UIColor whiteColor];
    text.delegate = self;
    text.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    text.returnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:text];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth-30, 30)];
    pleLabel.numberOfLines = 0;
    pleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    pleLabel.text = @" 请输入所提交内容";
    pleLabel.textColor = [UIColor colorHexString:@"888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [text addSubview:pleLabel];
    
    // Do any additional setup after loading the view.
}

- (void)showRight:(UIButton *)sender{
    self.callBackBlock(text.text);
    [self.navigationController popViewControllerAnimated:nil];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length) {
        pleLabel.alpha = 1;
    } else {
        pleLabel.alpha = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
