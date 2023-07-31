//
//  CommentViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/7/19.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
    UITableView *tableview;
    UITextView *textView;
    UILabel *pleLabel;
    
    NSMutableArray *array;
    
    NSInteger page;
}

@end

@implementation CommentViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self load];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 2;
    
    array = [NSMutableArray array];
    
    self.title = @"评论";
    [self createBarLeftWithImage:@"iconback"];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-zNavigationHeight-49) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:tableview];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, zScreenHeight-39, zScreenWidth, 39)];
    textView.layer.masksToBounds = YES;
    textView.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    textView.returnKeyType = UIReturnKeyDone;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [[UIColor colorHexString:@"ececec"] CGColor];
    textView.delegate = self;
    [self.view addSubview:textView];
    
    pleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 4.5, 100, 30)];
    
    pleLabel.text = @"请输入评论";
    pleLabel.textColor = [UIColor colorHexString:@"88888888"];
    pleLabel.textAlignment = NSTextAlignmentLeft;;
    [textView addSubview:pleLabel];
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, zScreenHeight-49, zScreenWidth, 49)];
//    [btn setBackgroundColor:[UIColor whiteColor]];
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
//    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(zScreenWidth/2, 12, 100, 25)];
//    titleLab.textAlignment = NSTextAlignmentLeft;
//    titleLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
//    titleLab.textColor = [UIColor colorHexString:@"383838"];
//    titleLab.text = @"评论";
//    [btn addSubview:titleLab];
//
//    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(zScreenWidth/2-20, 14.5, 20, 20)];
//    image.contentMode = UIViewContentModeCenter;
//    image.image = [UIImage imageNamed:@"icon_comment"];
//    [btn addSubview:image];
//
    
    [self addNoticeForKeyboard];
    
    
    // Do any additional setup after loading the view.
}

- (void)loadmoredata{
    {
        NSDictionary *param = @{@"pageNum":[NSNumber numberWithUnsignedInteger:page],@"pageSize":@"10",@"relationId":_relationIdstr};
        page++;
        [HTTPRequest postWithURL:@"yrycapi/signinrecord/getrecords" method:@"POST" params:param ProgressHUD:self.Hud controller:self response:^(id json) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:json];
            for (NSDictionary *dict in [dic objectForKey:@"list"]) {
                [array addObject:dict];
            }
            [tableview reloadData];
            [tableview.footer endRefreshing];
            
            if ([[dic objectForKey:@"list"] count] == 0) {
                [tableview.footer endRefreshingWithNoMoreData];
            }
            
            NSLog(@"second%@",json);
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
        
    }
}

- (void)load{
    [HTTPRequest postWithURL:@"api/comment/getList" method:@"POST" params: @{@"pageNum":@"1",@"pageSize":@"10",@"relationId":_relationIdstr} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"111111 ====== %@",json);
        
        array = [[json objectForKey:@"data"] objectForKey:@"list"];
        
        
        if ([[json objectForKey:@"total"] integerValue]>10) {
            tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoredata)];
        }
        
        
        [tableview reloadData];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
}

- (void)showLeft:(UIButton *)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = (textView.frame.origin.y+textView.frame.size.height+0) - (self.view.frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        if (textView.text.length>0) {
            [HTTPRequest postWithURL:@"api/comment/launch" method:@"POST" params: @{@"content":textView.text,@"relationId":_relationIdstr} ProgressHUD:self.Hud controller:self response:^(id json) {
                NSLog(@"111111 ====== %@",json);
                
                [self load];
                textView.text = @"";
                
                pleLabel.alpha = 1;
                
            } error400Code:^(id failure) {
                NSLog(@"%@",failure);
            }];
        }
        
        [textView resignFirstResponder];
        return NO;
        
        
        
        
    }
    return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        pleLabel.alpha = 0;
    } else {
        pleLabel.alpha = 1;
    }
}


- (void)click{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:14 weight:UIFontWeightThin]};
    NSString *contentStr= [array[indexPath.row] objectForKey:@"content"];
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(zScreenWidth-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;

    return 50+15+size.height+10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (!cell) {
        
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
    }
    
    [cell.headImg sd_setImageWithURL:[[array[indexPath.row] objectForKey:@"member"] objectForKey:@"portrait"]];
    cell.titleLab.text = [[array[indexPath.row] objectForKey:@"member"] objectForKey:@"nickname"];
    cell.timeLab.text = [array[indexPath.row] objectForKey:@"pushTimeSpace"];
    cell.contentLab.text = [array[indexPath.row] objectForKey:@"content"];
    CGSize size = [cell.contentLab sizeThatFits:CGSizeMake(zScreenWidth-30, MAXFLOAT)];
    cell.contentLab.frame = CGRectMake(15, 50+15, size.width, size.height);

    [cell addSubview:cell.contentLab];
    
    [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[array[indexPath.row] objectForKey:@"isFabulous"] integerValue] == 1) {
        cell.btn.selected = YES;
    }else{
        cell.btn.selected = NO;
    }
    
    cell.btn.tag = indexPath.row;
    return cell;
}

- (void)click:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if(sender.selected == NO){
        [HTTPRequest postWithURL:@"api/comment/addFabulous" method:@"POST" params: @{@"status":@"0",@"commentId":[array[sender.tag] objectForKey:@"commentId"]} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"111111 ====== %@",json);
            
            [self load];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
    }
    else{
        [HTTPRequest postWithURL:@"api/comment/addFabulous" method:@"POST" params: @{@"status":@"1",@"commentId":[array[sender.tag] objectForKey:@"commentId"]} ProgressHUD:self.Hud controller:self response:^(id json) {
            NSLog(@"111111 ====== %@",json);
            
            [self load];
            
        } error400Code:^(id failure) {
            NSLog(@"%@",failure);
        }];
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
