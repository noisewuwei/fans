//
//  GoodsDetailViewController.m
//  Fans
//
//  Created by 吴畏 on 2018/9/3.
//  Copyright © 2018年 吴畏. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "ConfirmOrderViewController.h"

@interface GoodsDetailViewController ()<UIWebViewDelegate,ChooseRankDelegate>{
    UIWebView *webview;
    
    NSString *number;
    NSString *typestr;
    NSString *pricestr;
    NSString *title;
    
    NSArray *typrarr;
    NSDictionary *imgdict;
    NSDictionary *pricedict;
    
}


@property(nonatomic,strong)UIView *backgroundView;

@property(nonatomic,strong)NSArray *standardList;
@property(nonatomic,strong)NSArray *standardValueList;

@end

@implementation GoodsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    NSDictionary *dic = [ZJStoreDefaults getObjectForKey:@"userinfo"];
    
    NSString *url = [NSString stringWithFormat:@"http://192.168.0.106:8888/app5.html?activityId=%@&token=%@",_str,[dic objectForKey:@"token"]];
    
    NSLog(@"%@",url);
    
    NSURL *weburl = [NSURL URLWithString:url];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:weburl];
    
    [webview loadRequest:request];
    
    [HTTPRequest postWithURL:@"api/activity/getproductlistforactivity" method:@"POST" params: @{@"activityId":_str} ProgressHUD:self.Hud controller:self response:^(id json) {
        NSLog(@"first success%@",json);
        
        NSDictionary *dic = [json objectForKey:@"data"];
        
        title = [dic objectForKey:@"title"];
        
        typrarr = [dic objectForKey:@"typeArray"];
        imgdict = [dic objectForKey:@"images"];
        pricedict = [dic objectForKey:@"prices"];
        
        self.standardList = @[@"类型"];
        self.standardValueList = @[typrarr];
        
        number = @"1";
        typestr = [self.standardValueList[0] objectAtIndex:0];
        pricestr = [pricedict objectForKey:typrarr[0]];
        
        [self initChooseView];
        
    } error400Code:^(id failure) {
        NSLog(@"%@",failure);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细内容";
    
    [self createBarLeftWithImage:@"iconback"];
    
    webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    
    webview.delegate = self;
    
    [self.view addSubview:webview];
    
    
    // Do any additional setup after loading the view.
}


-(void)initChooseView{
    
    self.chooseView = [[ChooseView alloc] initWithFrame:CGRectMake(0, zScreenHeight, zScreenWidth, zScreenHeight)];
    [self.chooseView.headImage sd_setImageWithURL:[imgdict objectForKey:typrarr[0]]];
    self.chooseView.LB_price.text = [pricedict objectForKey:typrarr[0]];
    self.chooseView.LB_stock.text = @"";
    self.chooseView.LB_detail.text = @"请选择商品规格";
    [self.view addSubview:self.chooseView];
    
    
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardList.count; i ++)
    {
        
        self.chooseRank = [[ChooseRank alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, zScreenWidth, 40)];
        maxY = CGRectGetMaxY(self.chooseRank.frame);
        height += self.chooseRank.height;
        self.chooseRank.tag = 8000+i;
        self.chooseRank.delegate = self;
        
        [self.chooseView.mainscrollview addSubview:self.chooseRank];
    }
    self.chooseView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    self.chooseView.headImage.backgroundColor = [UIColor blackColor];
    //加入购物车按钮
    //    [self.chooseView.addBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //立即购买
    [self.chooseView.buyBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //取消按钮
    [self.chooseView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.chooseView.alphaView addGestureRecognizer:tap];
}


-(void)addGoodsCartBtnClick{
    
    ConfirmOrderViewController *cvc = [[ConfirmOrderViewController alloc]init];
    cvc.num = number;
    cvc.type = typestr;
    cvc.price = pricestr;
    cvc.str = title;
    cvc.objectId = _str;
    
    [self dismiss];
    
    [self.navigationController pushViewController:cvc animated:YES];
    
    NSLog(@"加入购物车成功");
}

#pragma mark --立即购买
-(void)chooseViewClick{
    NSLog(@"--------");
    
}

/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss
{
    //    center.y = center.y+self.view.frame.size.height;
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, zScreenHeight , zScreenWidth, zScreenHeight);
        self.backgroundView.transform = CGAffineTransformIdentity;
    } completion: nil];
    
}
-(NSMutableArray *)rankArray{
    
    if (_rankArray == nil) {
        
        _rankArray = [[NSMutableArray alloc] init];
    }
    return _rankArray;
}

-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{
    
    [self.rankArray removeAllObjects];
    
    for (int i=0; i < _standardList.count; i++)
    {
        ChooseRank *view = [self.view viewWithTag:8000+i];
        
        for (UIButton *obj in  view.btnView.subviews)
        {
            if(obj.selected){
                
                for (NSArray *arr in self.standardValueList)
                {
                    for (NSString *title in arr) {
                        
                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {
                            
                            [self.rankArray addObject:view.selectBtn.titleLabel.text];
                        }
                    }
                }
            }
        }
    }
    //    NSLog(@"title%@",self.rankArray);
    
    
    if (btn.tag == 111 || btn.tag == 222) {
        NSLog(@"num%@",title);
        number = title;
    }else{
        NSLog(@"title%@",title);
        self.chooseView.LB_detail.text = title;
        
        self.chooseView.LB_price.text = [pricedict objectForKey:title];
        
        typestr = title;
        pricestr = [pricedict objectForKey:title];
    }
    
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //核心方法如下
    JSContext *content = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //此处的getMessage和JS方法中的getMessage名称一致.
    
    content[@"getSupport"] = ^() {
        
        [UIView animateWithDuration: 0.35 animations: ^{
            self.backgroundView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            self.chooseView.frame =CGRectMake(0, 0, zScreenWidth, zScreenHeight);
        } completion: nil];
        
    };
    
    content[@"getMore"] = ^() {
        
        NSLog(@"getmore");
        
    };
    
    //    content[@"getMessage"] = ^() {
    //
    //        NSLog(@"hahahahahah");
    //
    //        NSArray *arguments = [JSContext currentArguments];
    //        for (JSValue *jsValue in arguments) {
    //            NSLog(@"=======%@",jsValue);
    //        }
    //    };
    
    
    
    
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
